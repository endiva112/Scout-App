import 'package:flutter/material.dart';
import 'package:scout_app/widgets/cards/list_card.dart';
import 'package:scout_app/widgets/custom_divider.dart';
import 'package:scout_app/widgets/default_tip_text.dart';

class ShoppingListsCollection extends StatelessWidget {
  const ShoppingListsCollection({super.key});

  // TODO: reemplazar por llamada a Firestore
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 150),
      itemCount: _items.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (_, index) => _items[index],
    );
  }

  List<Widget> get _items => [
    CustomDivider(separatorText: 'Mis listas'),

    ListCard(type: ListType.simple,       title: 'Gastos de la casa',             items: 6, extraInfo: '3 tiendas',            listId: 'zmZYM6O1aWkWdL3pnai8'),
    ListCard(type: ListType.collaborative,title: 'Barbacoa',                       items: 2, extraInfo: 'Lidl',                 listId: 'zmZYM6O1aWkWdL3pnai8'),
    ListCard(type: ListType.recurring,    title: 'Pago del piso de Huelva',        items: 6, extraInfo: '10 días para el cobro',listId: 'zmZYM6O1aWkWdL3pnai8'),
    ListCard(type: ListType.recurring,    title: 'Pago del piso de Sevilla',       items: 6, extraInfo: 'DESACTIVADA',          listId: 'zmZYM6O1aWkWdL3pnai8'),
    ListCard(type: ListType.simple,       title: 'Gastos de casa de esos que tienen el nombre exageradamente largo y que rompen la UI', items: 6, extraInfo: '3 tiendas', listId: 'zmZYM6O1aWkWdL3pnai8'),

    CustomDivider(separatorText: 'Mis listas Mis listas Mis listas Mis listas'),

    DefaultTipText(tip: 'CREA LISTAS DE LA COMPRA, LISTAS COLABORATIVAS O GASTOS RECURRENTES'),
  ];
}