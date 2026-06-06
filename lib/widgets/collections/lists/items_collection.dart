import 'package:flutter/material.dart';
import 'package:scout_app/models/lists/item.dart';
import 'package:scout_app/repositories/lists/shopping_list_repository.dart';
import 'package:scout_app/theme/app_colors.dart';

class ItemsCollection extends StatelessWidget {
  final String listId;
  final String divisionId;

  ItemsCollection({
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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...items.map((item) => _buildItemRow(item)),
            _buildAddButton(context),
          ],
        );
      },
    );
  }

  Widget _buildItemRow(Item item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              item.name,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: 5),
          Container(
            width: 90,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.bgSecondary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              item.quantity,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: agregar item
      },
      child: Container(
        color: AppColors.bgSecondary,
        padding: const EdgeInsets.all(5),
        child: const Center(
          child: Text(
            'AGREGAR PRODUCTO',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textTerciary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}