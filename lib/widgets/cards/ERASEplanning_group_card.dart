/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scout_app/models/division.dart';
import 'package:scout_app/models/list_item.dart';
import 'package:scout_app/repositories/shopping_list_repository.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/common/bordered_container.dart';

class PlanningGroupCard extends StatefulWidget {
  final Division division;
  final String listId;

  const PlanningGroupCard({
    super.key,
    required this.division,
    required this.listId,
  });

  @override
  State<PlanningGroupCard> createState() => _PlanningGroupCardState();
}

// Capa de UI sobre un ListItem real de Firestore
class _ItemRow {
  final String itemId; // vacío si aún no se ha guardado
  final TextEditingController product;
  final TextEditingController unit;
  final FocusNode productFocus;
  final FocusNode unitFocus;
  bool hasFocus;

  _ItemRow({this.itemId = ''})
      : product = TextEditingController(),
        unit = TextEditingController(),
        productFocus = FocusNode(),
        unitFocus = FocusNode(),
        hasFocus = false;

  _ItemRow.fromItem(ListItem item)
      : itemId = item.id,
        product = TextEditingController(text: item.name),
        unit = TextEditingController(text: item.unit ?? ''),
        productFocus = FocusNode(),
        unitFocus = FocusNode(),
        hasFocus = false;

  void dispose() {
    product.dispose();
    unit.dispose();
    productFocus.dispose();
    unitFocus.dispose();
  }
}

class _PlanningGroupCardState extends State<PlanningGroupCard> {
  final _repository = ShoppingListRepository();
  final List<_ItemRow> _rows = [];
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  @override
  void dispose() {
    for (final row in _rows) {
      row.dispose();
    }
    super.dispose();
  }

  Future<void> _loadItems() async {
    final stream = _repository.getItems(widget.listId, widget.division.id);
    stream.first.then((items) {
      if (!mounted) return;
      setState(() {
        _rows.clear();
        for (final item in items) {
          _attachRow(_ItemRow.fromItem(item));
        }
        if (_rows.isEmpty) _attachRow(_ItemRow());
        _initialized = true;
      });
    });
  }

  void _attachRow(_ItemRow row) {
    row.productFocus.addListener(() {
      setState(() =>
          row.hasFocus = row.productFocus.hasFocus || row.unitFocus.hasFocus);
    });
    row.unitFocus.addListener(() {
      setState(() =>
          row.hasFocus = row.productFocus.hasFocus || row.unitFocus.hasFocus);
    });

    row.productFocus.onKeyEvent = (node, event) {
      if (event is KeyDownEvent) {
        if (event.logicalKey == LogicalKeyboardKey.enter) {
          _addRow(afterIndex: _rows.indexOf(row));
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.backspace &&
            row.product.text.isEmpty) {
          _removeRow(_rows.indexOf(row));
          return KeyEventResult.handled;
        }
      }
      return KeyEventResult.ignored;
    };

    // Guardar en Firestore al perder el foco
    row.productFocus.addListener(() async {
      if (!row.productFocus.hasFocus) {
        await Future.delayed(const Duration(milliseconds: 50));
        if (!row.productFocus.hasFocus && !row.unitFocus.hasFocus) {
          await _saveRow(row);
        }
      }
    });
    row.unitFocus.addListener(() async {
      if (!row.unitFocus.hasFocus) {
        await Future.delayed(const Duration(milliseconds: 50));
        if (!row.productFocus.hasFocus && !row.unitFocus.hasFocus) {
          await _saveRow(row);
        }
      }
    });

    _rows.add(row);
  }

  Future<void> _saveRow(_ItemRow row) async {
    if (row.product.text.trim().isEmpty) return;

    if (row.itemId.isEmpty) {
      // Crear
      final created = await _repository.createItem(
        widget.listId,
        widget.division.id,
        ListItem(
          id: '',
          name: row.product.text.trim(),
          unit: row.unit.text.trim().isEmpty ? null : row.unit.text.trim(),
          itemStatus: ItemStatus.available,
        ),
      );
      // Actualizamos el itemId en la fila para futuras ediciones
      _rows[_rows.indexOf(row)] = _ItemRow.fromItem(created)
        ..product.text = row.product.text
        ..unit.text = row.unit.text;
    } else {
      // Actualizar
      await _repository.updateItem(
        widget.listId,
        widget.division.id,
        ListItem(
          id: row.itemId,
          name: row.product.text.trim(),
          unit: row.unit.text.trim().isEmpty ? null : row.unit.text.trim(),
          itemStatus: ItemStatus.available,
        ),
      );
    }
  }

  void _addRow({bool requestFocus = true, int? afterIndex}) {
    final row = _ItemRow();
    _attachRow(row);

    setState(() {
      if (afterIndex != null) {
        _rows.remove(row);
        _rows.insert(afterIndex + 1, row);
      }
    });

    if (requestFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        row.productFocus.requestFocus();
      });
    }
  }

  Future<void> _removeRow(int index) async {
    if (_rows.length <= 1) return;

    final row = _rows[index];
    final previousRow = index > 0 ? _rows[index - 1] : null;

    if (row.itemId.isNotEmpty) {
      await _repository.deleteItem(
        widget.listId,
        widget.division.id,
        row.itemId,
      );
    }

    setState(() => _rows.removeAt(index));
    row.dispose();

    if (previousRow != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        previousRow.productFocus.requestFocus();
        previousRow.product.selection = TextSelection.fromPosition(
          TextPosition(offset: previousRow.product.text.length),
        );
      });
    }
  }

  void _showDivisionMenu(BuildContext context, Offset position) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(position.dx, position.dy, position.dx, position.dy),
      items: [
        PopupMenuItem(
          value: 'delete',
          child: ListTile(
            dense: true,
            title: const Text('Eliminar tienda', style: TextStyle(color: AppColors.negative)),
            trailing: const Icon(Icons.delete_outline, color: AppColors.negative),
            contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          ),
        ),
      ],
    ).then((value) {
      if (value == 'delete') {
        _repository.deleteDivisionWithItems(widget.listId, widget.division.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const BorderedContainer(
        borderColor: AppColors.borderAccent,
        borderWidth: 1,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return GestureDetector(
      onLongPressStart: (details) => _showDivisionMenu(context, details.globalPosition),
      child: BorderedContainer(
        borderColor: AppColors.borderAccent,
        borderWidth: 1,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.division.name.isEmpty
                    ? 'Sin tienda asignada'
                    : widget.division.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              ..._rows.asMap().entries.map((entry) =>
                  _buildItemRow(entry.value, entry.key)),
              _buildAddItemButton(),
            ]
          )
        )
      )
    );
  }

  Widget _buildItemRow(_ItemRow row, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.lock_rounded, color: AppColors.bgSecondary, size: 16),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: row.product,
              focusNode: row.productFocus,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 4),
                border: InputBorder.none,
                hintText: 'Producto',
                hintStyle: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w400,
                ),
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
              controller: row.unit,
              focusNode: row.unitFocus,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.all(5),
                border: InputBorder.none,
                hintText: 'Ud.',
                hintStyle: TextStyle(
                  fontSize: 13,
                  color: AppColors.textTerciary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddItemButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: _addRow,
        child: Container(
          color: AppColors.bgSecondary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  'AGREGAR PRODUCTO',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textTerciary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/