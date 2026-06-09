import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/buttons/add_division_button.dart';
import 'package:scout_app/widgets/collections/lists/collaborative_divisions_collection.dart';
import 'package:scout_app/widgets/common/last_modified_text.dart';

class CollaborativePlanningBody extends StatelessWidget {
  final String listId;
  final DateTime updatedAt;

  const CollaborativePlanningBody({
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
            CollaborativeDivisionsCollection(listId: listId),
            AddDivisionButton(listId: listId),
          ],
        ),
      ),
    );
  }
}