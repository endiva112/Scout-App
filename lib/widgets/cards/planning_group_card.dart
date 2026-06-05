import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/common/bordered_container.dart';

class PlanningGroupCard extends StatefulWidget {
  const PlanningGroupCard({super.key});

  @override
  State<PlanningGroupCard> createState() => _PlanningGroupCardState();
}

class _ItemData {
  final TextEditingController product;
  final TextEditingController unit;
  final FocusNode productFocus;
  final FocusNode unitFocus;
  bool locked;
  bool hasFocus;

  _ItemData()
      : product = TextEditingController(),
        unit = TextEditingController(),
        productFocus = FocusNode(),
        unitFocus = FocusNode(),
        locked = false,
        hasFocus = false;

  void dispose() {
    product.dispose();
    unit.dispose();
    productFocus.dispose();
    unitFocus.dispose();
  }
}

class _PlanningGroupCardState extends State<PlanningGroupCard> {
  final List<_ItemData> _items = [];

  @override
  void initState() {
    super.initState();
    _addItem(requestFocus: false);
  }

  void _addItem({bool requestFocus = true, int? afterIndex}) {
    final item = _ItemData();

    item.productFocus.addListener(() {
      setState(() =>
          item.hasFocus =
              item.productFocus.hasFocus || item.unitFocus.hasFocus);
    });
    item.unitFocus.addListener(() {
      setState(() =>
          item.hasFocus =
              item.productFocus.hasFocus || item.unitFocus.hasFocus);
    });

    item.productFocus.onKeyEvent = (node, event) {
      if (event is KeyDownEvent) {
        if (event.logicalKey == LogicalKeyboardKey.enter) {
          _addItem(afterIndex: _items.indexOf(item));
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.backspace &&
            item.product.text.isEmpty) {
          _removeItem(_items.indexOf(item));
          return KeyEventResult.handled;
        }
      }
      return KeyEventResult.ignored;
    };

    setState(() {
      if (afterIndex != null) {
        _items.insert(afterIndex + 1, item);
      } else {
        _items.add(item);
      }
    });

    if (requestFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        item.productFocus.requestFocus();
      });
    }
  }

  void _removeItem(int index) {
    if (_items.length <= 1) return;

    final item = _items[index];
    final previousItem = index > 0 ? _items[index - 1] : null;

    setState(() => _items.removeAt(index));
    item.dispose();

    if (previousItem != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        previousItem.productFocus.requestFocus();
        previousItem.product.selection = TextSelection.fromPosition(
          TextPosition(offset: previousItem.product.text.length),
        );
      });
    }
  }

  @override
  void dispose() {
    for (final item in _items) {
      item.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BorderedContainer(
      borderColor: AppColors.borderAccent,
      borderWidth: 1,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Sin tienda asignada',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            ..._items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return _buildItemRow(item, index);
            }),
            _buildAddItemButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildItemRow(_ItemData item, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.lock_rounded,
            color: AppColors.bgSecondary,
            size: 16,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: item.product,
              focusNode: item.productFocus,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              style: TextStyle(
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
              controller: item.unit,
              focusNode: item.unitFocus,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(5),
                border: InputBorder.none,
                hintText: 'Ud.',
                hintStyle: TextStyle(
                  fontSize: 13,
                  color: AppColors.textTerciary,
                  fontWeight: FontWeight.w400,
                )
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
        onTap: _addItem,
        child: Container(
          color: AppColors.bgSecondary,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsetsGeometry.all(5),
                child: Text(
                  'AGREGAR PRODUCTO',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textTerciary,
                    fontWeight: FontWeight.w400,
                  )
                )
              )
            ]
          )
        )
      )
    );
  }
}