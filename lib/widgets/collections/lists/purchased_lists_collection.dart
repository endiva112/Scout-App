import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scout_app/models/lists/shopping_list.dart';
import 'package:scout_app/repositories/lists/shopping_list_repository.dart';
import 'package:scout_app/widgets/cards/paid_list_card.dart';
import 'package:scout_app/widgets/common/custom_divider.dart';
import 'package:scout_app/widgets/common/default_tip_text.dart';

class PurchasedListsCollection extends StatelessWidget {
  PurchasedListsCollection({super.key});

  final _repository = ShoppingListRepository();
  final _userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ShoppingList>>(
      stream: _repository.getSettlingLists(_userId),
      builder: (context, settlingSnapshot) {
        return StreamBuilder<List<ShoppingList>>(
          stream: _repository.getArchivedLists(_userId),
          builder: (context, archivedSnapshot) {
            if (settlingSnapshot.connectionState == ConnectionState.waiting ||
                archivedSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (settlingSnapshot.hasError || archivedSnapshot.hasError) {
              return const DefaultTipText(
                tip: 'PARECE QUE ALGO SALIÓ MAL [ERROR EN LA CONEXIÓN AL SERVIDOR DE DATOS]',
              );
            }

            final settling = settlingSnapshot.data ?? [];
            final archived = archivedSnapshot.data ?? [];
            final items = _buildItems(context, settling, archived);

            return ListView.separated(
              padding: const EdgeInsets.only(bottom: 150),
              itemCount: items.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (_, index) => items[index],
            );
          },
        );
      },
    );
  }

  List<Widget> _buildItems(
    BuildContext context,
    List<ShoppingList> settling,
    List<ShoppingList> archived,
  ) {
    final items = <Widget>[];

    //items.add(const CustomDivider(separatorText: 'Pendientes de pago'));
    /*
    if (settling.isEmpty) {
      items.add(const DefaultTipText(
        tip: 'PARECE QUE NO QUEDAN LISTAS POR PAGAR',
      ));
    } else {
      for (final list in settling) {
        items.add(PaidListCard(
          title: list.title,
          statusLabel: 'Comprado: ' ,
          amount: _formatDate(list.updatedAt),
          isPaid: false,
          /* TODO 2 esto no debe tener editar y borrar es algo que solo deberia poder hacer el dueño
          onEdit: () => context.push('/lists/simple_list/${list.id}'),
          onDelete: () => _repository.deleteList(list.id),*/
        ));
      }
    }

    items.add(const SizedBox(height: 50));*/
    items.add(const CustomDivider(separatorText: 'Historial'));

    if (archived.isEmpty) {
      items.add(const DefaultTipText(
        tip: 'EL HISTORIAL ESTÁ VACÍO, LAS LISTAS QUE YA HAYAS USADO PERMANECERÁN AQUÍ UN TIEMPO ANTES DE BORRARSE',
      ));
    } else {
      for (final list in archived) {
        items.add(PaidListCard(
          title: list.title,
          statusLabel: 'Último pago: ' ,
          amount: _formatDate(list.updatedAt),
          isPaid: true,
          onReuse: () => _repository.reuseList(list.id, _userId),
          onDelete: () async {
            final owner = await _repository.isOwner(list.id, _userId);
            if (owner) {
              await _repository.deleteList(list.id);
            } else {
              await _repository.leaveList(list.id, _userId);
            }
          }
        ));
      }
    }

    return items;
  }

  String _formatDate(DateTime date) {
    const months = [
      'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun',
      'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}