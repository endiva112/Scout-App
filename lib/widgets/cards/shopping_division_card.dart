import 'package:flutter/material.dart';
import 'package:scout_app/models/lists/division.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/collections/lists/shopping_items_collection.dart';
import 'package:scout_app/widgets/common/bordered_container.dart';

class ShoppingDivisionCard extends StatelessWidget {
  final String listId;
  final Division division;

  const ShoppingDivisionCard({
    super.key,
    required this.listId,
    required this.division,
  });

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
              division.name.isEmpty ? 'Sin tienda asignada' : division.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            ShoppingItemsCollection(
              listId: listId,
              divisionId: division.id,
            ),
          ],
        ),
      ),
    );
  }
}