import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/collections/lists/collaborative_shopping_divisions_collection.dart';
import 'package:scout_app/widgets/common/last_modified_text.dart';

class CollaborativeShoppingBody extends StatelessWidget {
  final String listId;
  final DateTime updatedAt;

  const CollaborativeShoppingBody({
    super.key,
    required this.listId,
    required this.updatedAt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bgSecondary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            LastModifiedText(updatedAt: updatedAt),
            const SizedBox(height: 10),
            CollaborativeShoppingDivisionsCollection(listId: listId),
          ],
        ),
      ),
    );
  }
}