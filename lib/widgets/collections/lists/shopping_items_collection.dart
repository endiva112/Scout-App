import 'package:flutter/material.dart';
import 'package:scout_app/models/lists/item.dart';
import 'package:scout_app/repositories/lists/shopping_list_repository.dart';
import 'package:scout_app/theme/app_colors.dart';

class ShoppingItemsCollection extends StatelessWidget {
  final String listId;
  final String divisionId;

  ShoppingItemsCollection({
    super.key,
    required this.listId,
    required this.divisionId,
  });

  final _repository = ShoppingListRepository();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Item>>(
      stream: _repository.getItems(listId, divisionId),
      builder: (context, snapshot) {
        final items = snapshot.data ?? [];
        if (items.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: items.map((item) => _buildItemRow(item)).toList(),
        );
      },
    );
  }

  Widget _buildItemRow(Item item) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => _repository.saveItem(
        listId,
        divisionId,
        item.copyWith(checked: !item.checked),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: item.checked ? AppColors.bgTerciary : AppColors.textPrimary,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                item.name,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: item.checked ? FontWeight.w300 : FontWeight.w500,
                  color: item.checked ? AppColors.textTerciary : AppColors.textPrimary,
                  decoration: item.checked
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationColor: AppColors.textTerciary,
                  decorationThickness: 2,
                ),
              ),
            ),
            Text(
              item.quantity,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: item.checked ? FontWeight.w300 : FontWeight.w500,
                color: item.checked ? AppColors.textTerciary : AppColors.textPrimary,
                decoration: item.checked
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                decorationColor: AppColors.textTerciary,
                decorationThickness: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}