  import 'dart:async';
  import 'package:flutter/foundation.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';
  import 'package:provider/provider.dart';
  import 'package:scout_app/models/lists/item.dart';
  import 'package:scout_app/models/lists/item_row.dart';
  import 'package:scout_app/repositories/lists/shopping_list_repository.dart';
  import 'package:scout_app/theme/app_colors.dart';
  import 'package:scout_app/widgets/common/bordered_container.dart';
  import 'package:scout_app/widgets/lists/editing_session_provider.dart';

  class ItemsCollection extends StatefulWidget {
    final String listId;
    final String divisionId;

    const ItemsCollection({
      super.key,
      required this.listId,
      required this.divisionId,
    });

    @override
    State<ItemsCollection> createState() => _ItemsCollectionState();
  }

  class _ItemsCollectionState extends State<ItemsCollection> {
    final _repository = ShoppingListRepository();

    StreamSubscription<List<Item>>? _subscription;
    bool _disposed = false;
    bool _wasEditing = false;
    int _tempId = 0;
    late final String _sessionKey;
    bool _saving = false;

    // Guardamos referencia al provider en didChangeDependencies,
    // así nunca tocamos context fuera del ciclo de vida seguro.
    EditingSessionProvider? _editingSession;

    // ── Fuente de verdad única ──────────────────────────────────────────────────
    final List<ItemRow> _rows = [];

    final Map<String, TextEditingController> _nameControllers = {};
    final Map<String, TextEditingController> _qtyControllers = {};
    final Map<String, FocusNode> _nameFocus = {};
    final Map<String, FocusNode> _qtyFocus = {};

    // ── Lifecycle ───────────────────────────────────────────────────────────────

    @override
    void initState() {
      super.initState();
      _sessionKey = '${widget.listId}${widget.divisionId}';
      _subscribe();
    }

    @override
    void didChangeDependencies() {
      super.didChangeDependencies();
      _editingSession = context.watch<EditingSessionProvider>();
      _editingSession!.registerSaveCallback(_sessionKey, _saveAll);

      final isEditing = _editingSession!.isEditing;
      if (isEditing && !_wasEditing) {
        _subscription?.cancel();
        _subscription = null;
      }

      _wasEditing = isEditing;
    }

    @override
    void dispose() {
      _disposed = true; // Lo primero, antes de cancelar nada
      // Usamos la referencia guardada — nunca context.read en dispose.
      _editingSession?.unregisterSaveCallback(_sessionKey);
      _subscription?.cancel();
      _subscription = null;
      for (final c in _nameControllers.values) { c.dispose(); }
      for (final c in _qtyControllers.values) { c.dispose(); }
      for (final f in _nameFocus.values) { f.dispose(); }
      for (final f in _qtyFocus.values) { f.dispose(); }
      super.dispose();
    }

    // ── Stream de Firestore ─────────────────────────────────────────────────────

    void _subscribe() {
      _subscription = _repository
          .getItems(widget.listId, widget.divisionId)
          .listen(_onFirestoreItems);
    }

  void _onFirestoreItems(List<Item> items) {
    if (_disposed) return;
    if (_saving) {
      debugPrint('[$_sessionKey] snapshot ignorado por _saving');
      return;
      }

    final incomingIds = items.map((i) => i.id).toList();
    final currentSyncedIds = _rows
        .where((r) => !r.isLocal && !r.isPendingDelete)
        .map((r) => r.id)
        .toList();

    debugPrint('[$_sessionKey] incoming: $incomingIds');
    debugPrint('[$_sessionKey] currentSynced: $currentSyncedIds');
    debugPrint('[$_sessionKey] _saving: $_saving, _wasEditing: $_wasEditing');

    // Si la estructura no cambió, solo sincronizamos texto sin redibujar
    if (listEquals(incomingIds, currentSyncedIds)) {
      debugPrint('[$_sessionKey] fast-exit, sin redibujado');
      for (final item in items) {
        if (!(_nameFocus[item.id]?.hasFocus ?? false)) {
          final nameCtrl = _nameControllers[item.id];
          if (nameCtrl != null && nameCtrl.text != item.name) {
            nameCtrl.text = item.name;
          }
        }
        if (!(_qtyFocus[item.id]?.hasFocus ?? false)) {
          final qtyCtrl = _qtyControllers[item.id];
          if (qtyCtrl != null && qtyCtrl.text != item.quantity) {
            qtyCtrl.text = item.quantity;
          }
        }
      }
      return;
    }

    // Hay cambio estructural (item nuevo, eliminado, o reordenado)
    // Creamos controllers para los que aún no existen
    for (final item in items) {
      final alreadyKnown = _rows.any((r) => r.id == item.id);
      if (!alreadyKnown) {
        _nameControllers[item.id] = TextEditingController(text: item.name);
        _qtyControllers[item.id] = TextEditingController(text: item.quantity);
        _nameFocus[item.id] = _buildFocusNode(item.id);
        _qtyFocus[item.id] = _buildFocusNode(item.id);
      }
    }

    debugPrint('[$_sessionKey] setState - cambio estructural');
    setState(() {
      for (final item in items) {
        final existingIndex = _rows.indexWhere((r) => r.id == item.id);

        if (existingIndex == -1) {
          final insertAt = _rows.lastIndexWhere((r) => !r.isLocal) + 1;
          _rows.insert(insertAt, ItemRow(id: item.id, state: RowState.synced));
        } else {
          final row = _rows[existingIndex];
          if (!row.isPendingDelete) {
            if (!(_nameFocus[item.id]?.hasFocus ?? false)) {
              final nameCtrl = _nameControllers[item.id];
              if (nameCtrl != null && nameCtrl.text != item.name) {
                nameCtrl.text = item.name;
              }
            }
            if (!(_qtyFocus[item.id]?.hasFocus ?? false)) {
              final qtyCtrl = _qtyControllers[item.id];
              if (qtyCtrl != null && qtyCtrl.text != item.quantity) {
                qtyCtrl.text = item.quantity;
              }
            }
          }
        }
      }

      _rows.removeWhere((row) {
        if (row.isLocal) return false;
        if (incomingIds.contains(row.id)) return false;
        _disposeRow(row.id);
        return true;
      });
    });
  }

    // ── Helpers de controllers / focus ─────────────────────────────────────────

    FocusNode _buildFocusNode(String id) {
      final session = _editingSession;
      final node = FocusNode();
      node.addListener(() {
        if (!mounted) return;
        if (node.hasFocus) {
          session?.onUserStartedEditing();
        } else {
          session?.onUserStoppedEditing();
        }
      });
      return node;
    }

    void _disposeRow(String id) {
      _nameControllers.remove(id)?.dispose();
      _qtyControllers.remove(id)?.dispose();
      _nameFocus.remove(id)?.dispose();
      _qtyFocus.remove(id)?.dispose();
    }

    // ── Lógica de filas ─────────────────────────────────────────────────────────

    void _addLocalRow() {
      final id = 'local_${_tempId++}';
      _nameControllers[id] = TextEditingController();
      _qtyControllers[id] = TextEditingController();
      _nameFocus[id] = _buildFocusNode(id);
      _qtyFocus[id] = _buildFocusNode(id);
      setState(() {
        _rows.add(ItemRow(id: id, state: RowState.localOnly));
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _nameFocus[id]?.requestFocus();
      });
    }

    void _onBackspaceOnEmpty(String id) {
      final visibleRows = _rows.where((r) => r.isVisible).toList();
      final index = visibleRows.indexWhere((r) => r.id == id);

      _markRowForDeletion(id);

      if (index <= 0) return;

      final previousId = visibleRows[index - 1].id;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final focusNode = _nameFocus[previousId];
        final controller = _nameControllers[previousId];
        if (focusNode == null || controller == null) return;

        focusNode.requestFocus();
        controller.selection = TextSelection.collapsed(
          offset: controller.text.length,
        );
      });
    }

    void _markRowForDeletion(String id) {
      final index = _rows.indexWhere((r) => r.id == id);
      if (index == -1) return;

      final row = _rows[index];

      if (row.isLocal) {
        setState(() => _rows.removeAt(index));
        _disposeRow(id);
      } else {
        setState(() {
          _rows[index] = row.copyWith(state: RowState.pendingDelete);
        });
      }
    }

    // ── Guardado ────────────────────────────────────────────────────────────────

    Future<void> _saveAll() async {
      _saving = true;
      _subscription?.cancel(); // nos aseguramos de que está parado
      _subscription = null;
      
      final rowsSnapshot = List<ItemRow>.from(_rows);

      for (final row in rowsSnapshot) {
        switch (row.state) {
          case RowState.localOnly:
            await _saveLocalRow(row);
          case RowState.pendingDelete:
            await _repository.deleteItem(widget.listId, widget.divisionId, row.id);
            await _repository.decrementItemCount(widget.listId);
            if (mounted) {
              setState(() => _rows.removeWhere((r) => r.id == row.id));
            }
            _disposeRow(row.id);
          case RowState.synced:
            break;
          case RowState.dirty:
            await _updateRow(row);
        }
      }

      _saving = false;
      _subscribe(); // reactivamos aquí, cuando _rows ya está en estado final
    }

    Future<void> _saveLocalRow(ItemRow row) async {
      final name = _nameControllers[row.id]?.text.trim() ?? '';
      final qty = _qtyControllers[row.id]?.text.trim() ?? '';

      debugPrint('[saveLocalRow] id: ${row.id}, name: "$name", qty: "$qty"');

      if (name.isEmpty && qty.isEmpty) {
        debugPrint('[saveLocalRow] vacío → eliminando fila');
        if (mounted) setState(() => _rows.removeWhere((r) => r.id == row.id));
        _disposeRow(row.id);
        return;
      }

      final saved = await _repository.saveItem(
        widget.listId,
        widget.divisionId,
        Item(id: '', name: name, quantity: qty, checked: false),
      );
      await _repository.incrementItemCount(widget.listId);

      if (!mounted) return;

      final index = _rows.indexWhere((r) => r.id == row.id);
      debugPrint('[saveLocalRow] index tras save: $index, saved.id: ${saved.id}');

      if (index != -1) {
        final localId = row.id;
        final realId = saved.id;

        _nameControllers[realId] = _nameControllers.remove(localId)!;
        _qtyControllers[realId] = _qtyControllers.remove(localId)!;
        _nameFocus[realId] = _nameFocus.remove(localId)!;
        _qtyFocus[realId] = _qtyFocus.remove(localId)!;

        setState(() {
          _rows[index] = ItemRow(id: realId, state: RowState.synced);
        });
        debugPrint('[saveLocalRow] fila local → synced con id: $realId');
      } else {
        debugPrint('[saveLocalRow] fila ya no existe en _rows');
      }
    }

    Future<void> _updateRow(ItemRow row) async {
      final name = _nameControllers[row.id]?.text.trim() ?? '';
      final qty = _qtyControllers[row.id]?.text.trim() ?? '';
      try {
        await _repository.saveItem(
          widget.listId,
          widget.divisionId,
          Item(id: row.id, name: name, quantity: qty, checked: false),
        );
        if (mounted) {
          final index = _rows.indexWhere((r) => r.id == row.id);
          if (index != -1) {
            setState(() {
              _rows[index] = row.copyWith(state: RowState.synced);
            });
          }
        }
      } catch (e) {
        debugPrint('Error actualizando item ${row.id}: $e');
      }
    }

    void _markDirtyIfNeeded(String id) {
      final index = _rows.indexWhere((r) => r.id == id);
      if (index == -1) return;
      final row = _rows[index];
      if (row.state == RowState.synced) {
        setState(() {
          _rows[index] = row.copyWith(state: RowState.dirty);
        });
      }
    }

    // ── Build ───────────────────────────────────────────────────────────────────

    @override
    Widget build(BuildContext context) {
      final visibleRows = _rows.where((r) => r.isVisible).toList();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...visibleRows.map((row) => _buildRow(row.id)),
          _buildAddButton(),
        ],
      );
    }

    Widget _buildRow(String id) {
      return Padding(
        key: ValueKey(id),
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            const Icon(Icons.circle, color: AppColors.bgPrimary, size: 16),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _nameControllers[id],
                focusNode: _nameFocus[id],
                style: const TextStyle(fontSize: 12),
                decoration: const InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: 'Producto',
                ),
                onChanged: (value) {
                  _markDirtyIfNeeded(id);
                  final qty = _qtyControllers[id]?.text.trim() ?? '';
                  if (value.trim().isEmpty && qty.isEmpty) {
                    _markRowForDeletion(id);
                  }
                },
              ),
            ),
            const SizedBox(width: 5),
            Container(
              width: 90,
              decoration: BoxDecoration(
                color: AppColors.bgSecondary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _qtyControllers[id],
                focusNode: _qtyFocus[id],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
                decoration: const InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: 'Ud.',
                ),
                onChanged: (_) => _markDirtyIfNeeded(id),
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildAddButton() {
      return GestureDetector(
        onTap: _addLocalRow,
        child: BorderedContainer(
          borderRadius: 8,
          elevation: 0,
          backgroundColor: AppColors.bgSecondary,
          padding: const EdgeInsets.all(5),
          child: const Center(
            child: Text(
              'AGREGAR PRODUCTO',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textTerciary,
              ),
            ),
          ),
        ),
      );
    }
  }