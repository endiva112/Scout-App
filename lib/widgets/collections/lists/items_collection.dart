import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scout_app/models/lists/item.dart';
import 'package:scout_app/repositories/lists/shopping_list_repository.dart';
import 'package:scout_app/theme/app_colors.dart';
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
  List<Item> _storedItems = [];
  bool _wasEditing = false;

  // Filas locales (sin ID de Firestore)
  final List<String> _localIds = [];

  // Controllers y focus para TODOS los rows (locales y guardados)
  // Clave: firestoreId para guardados, 'local_N' para locales
  final Map<String, TextEditingController> _nameControllers = {};
  final Map<String, TextEditingController> _qtyControllers = {};
  final Map<String, FocusNode> _nameFocus = {};
  final Map<String, FocusNode> _qtyFocus = {};

  int _tempId = 0;
  late final String _sessionKey;

  @override
  void initState() {
    super.initState();
    _sessionKey = '${widget.listId}_${widget.divisionId}';
    _subscribe();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = context.watch<EditingSessionProvider>();
    provider.registerSaveCallback(_sessionKey, _saveAll);

    final isEditing = provider.isEditing;
    if (isEditing && !_wasEditing) {
      _subscription?.cancel();
      _subscription = null;
    } else if (!isEditing && _wasEditing) {
      _subscribe();
    }
    _wasEditing = isEditing;
  }

  @override
  void dispose() {
    context.read<EditingSessionProvider>().unregisterSaveCallback(_sessionKey);
    _subscription?.cancel();
    for (final c in _nameControllers.values) c.dispose();
    for (final c in _qtyControllers.values) c.dispose();
    for (final f in _nameFocus.values) f.dispose();
    for (final f in _qtyFocus.values) f.dispose();
    super.dispose();
  }

  void _subscribe() {
    _subscription = _repository
        .getItems(widget.listId, widget.divisionId)
        .listen((items) {
      if (!mounted) return;
      setState(() {
        // Sincroniza controllers con los items de Firestore,
        // sin tocar los que ya tienen foco.
        for (final item in items) {
          if (!_nameControllers.containsKey(item.id)) {
            // Item nuevo que llega de Firestore: crea controllers
            _nameControllers[item.id] = TextEditingController(text: item.name);
            _qtyControllers[item.id] = TextEditingController(text: item.quantity);
            _nameFocus[item.id] = _buildFocusNode();
            _qtyFocus[item.id] = _buildFocusNode();
          } else {
            // Item que ya conocemos: actualiza solo si no tiene foco
            if (!(_nameFocus[item.id]?.hasFocus ?? false)) {
              _nameControllers[item.id]?.text = item.name;
            }
            if (!(_qtyFocus[item.id]?.hasFocus ?? false)) {
              _qtyControllers[item.id]?.text = item.quantity;
            }
          }
        }

        // Limpia controllers de items que ya no existen en Firestore
        final currentIds = items.map((i) => i.id).toSet();
        final removedIds = _storedItems
            .map((i) => i.id)
            .where((id) => !currentIds.contains(id))
            .toList();
        for (final id in removedIds) {
          _nameControllers.remove(id)?.dispose();
          _qtyControllers.remove(id)?.dispose();
          _nameFocus.remove(id)?.dispose();
          _qtyFocus.remove(id)?.dispose();
        }

        _storedItems = items;
      });
    });
  }

  FocusNode _buildFocusNode() {
    final provider = context.read<EditingSessionProvider>();
    final node = FocusNode();
    node.addListener(() {
      if (node.hasFocus) {
        provider.onUserStartedEditing();
      } else {
        provider.onUserStoppedEditing();
      }
    });
    return node;
  }

  void _addLocalRow() {
    final id = 'local_${_tempId++}';
    _localIds.add(id);
    _nameControllers[id] = TextEditingController();
    _qtyControllers[id] = TextEditingController();
    _nameFocus[id] = _buildFocusNode();
    _qtyFocus[id] = _buildFocusNode();
    setState(() {});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _nameFocus[id]?.requestFocus();
    });
  }

  /// Guarda todo: items locales (create) e items guardados modificados (update)
  Future<void> _saveAll() async {
    // 1. Guarda filas locales nuevas
    for (final id in List<String>.from(_localIds)) {
      final name = _nameControllers[id]?.text.trim() ?? '';
      final qty = _qtyControllers[id]?.text.trim() ?? '';
      if (name.isEmpty && qty.isEmpty) {
        _removeRow(id);
        continue;
      }
      await _repository.saveItem(
        widget.listId,
        widget.divisionId,
        Item(id: '', name: name, quantity: qty, checked: false),
      );
      await _repository.incrementItemCount(widget.listId);
      _removeRow(id);
    }

    // 2. Actualiza items guardados que hayan sido editados
    for (final item in _storedItems) {
      final name = _nameControllers[item.id]?.text.trim() ?? item.name;
      final qty = _qtyControllers[item.id]?.text.trim() ?? item.quantity;
      if (name != item.name || qty != item.quantity) {
        await _repository.saveItem(
          widget.listId,
          widget.divisionId,
          item.copyWith(name: name, quantity: qty),
        );
      }
    }
  }

  void _removeRow(String id) {
    _localIds.remove(id);
    _nameControllers.remove(id)?.dispose();
    _qtyControllers.remove(id)?.dispose();
    _nameFocus.remove(id)?.dispose();
    _qtyFocus.remove(id)?.dispose();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ..._storedItems.map((item) => _buildRow(item.id)),
        ..._localIds.map(_buildRow),
        _buildAddButton(),
      ],
    );
  }

  // Un único _buildRow para locales y guardados
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: _addLocalRow,
      child: Container(
        color: AppColors.bgSecondary,
        padding: const EdgeInsets.all(6),
        child: const Center(
          child: Text('AGREGAR PRODUCTO', style: TextStyle(fontSize: 13)),
        ),
      ),
    );
  }
}