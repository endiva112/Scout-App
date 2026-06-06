import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scout_app/models/lists/shopping_list.dart';
import 'package:scout_app/repositories/lists/shopping_list_repository.dart';
import 'package:scout_app/widgets/cards/list_card.dart';
import 'package:scout_app/widgets/common/custom_divider.dart';
import 'package:scout_app/widgets/common/default_tip_text.dart';
import 'package:go_router/go_router.dart';

class ShoppingListsCollection extends StatelessWidget {
  ShoppingListsCollection({super.key});

  final _repository = ShoppingListRepository();
  final _userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ShoppingList>>(
      stream: _repository.getShoppingLists(_userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const DefaultTipText(
            tip: 'PARECE QUE ALGO SALIÓ MAL [ERROR EN LA CONEXIÓN AL SERVIDOR DE DATOS]',
          );
        }

        final lists = snapshot.data ?? [];

        if (lists.isEmpty) {
          return const DefaultTipText(
            tip: 'CREA LISTAS DE LA COMPRA, LISTAS COLABORATIVAS O GASTOS RECURRENTES',
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.only(bottom: 150),
          itemCount: lists.length + 1, // +1 para el divider inicial
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (_, index) {
            if (index == 0) {
              return const CustomDivider(separatorText: 'Mis listas');
            }
            final list = lists[index - 1];
            return ListCard(
              type: list.type,
              title: list.title,
              items: list.itemCount,
              extraInfo: '${list.divisionCount} tiendas o supermercados',
              listId: list.id,
              onEdit: () => context.push(
                list.type == ListType.simple
                    ? '/lists/simple_list/${list.id}'
                    : '/lists/collaborative_list/${list.id}',
              ),
              onDelete: () => _repository.deleteList(list.id),
            );
          },
        );
      },
    );
  }
}