import 'package:flutter/material.dart';
import 'package:scout_app/models/lists/division.dart';
import 'package:scout_app/repositories/lists/shopping_list_repository.dart';
import 'package:scout_app/widgets/common/default_tip_text.dart';
import 'package:scout_app/widgets/cards/shopping_division_card.dart';

class ShoppingDivisionsCollection extends StatelessWidget {
  final String listId;

  ShoppingDivisionsCollection({
    super.key,
    required this.listId,
  });

  final _repository = ShoppingListRepository();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Division>>(
      stream: _repository.getDivisions(listId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const DefaultTipText(
            tip: 'PARECE QUE ALGO SALIÓ MAL [ERROR EN LA CONEXIÓN AL SERVIDOR DE DATOS]',
          );
        }

        final divisions = snapshot.data ?? [];
        if (divisions.isEmpty) return const SizedBox.shrink();

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: divisions.length,
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (_, index) {
            final division = divisions[index];
            return ShoppingDivisionCard(
              key: ValueKey(division.id),
              listId: listId,
              division: division,
            );
          },
        );
      },
    );
  }
}