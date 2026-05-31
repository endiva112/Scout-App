import 'package:flutter/material.dart';
import 'package:scout_app/widgets/cards/billing_card.dart';
import 'package:scout_app/widgets/cards/paid_list_card.dart';
import 'package:scout_app/widgets/common/custom_divider.dart';
import 'package:scout_app/widgets/common/default_tip_text.dart';

class PurchasedListsCollection extends StatelessWidget {
  const PurchasedListsCollection({super.key});

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

    PaidListCard(
      title: 'Barbacoa',
      statusLabel: 'Comprado: 24 Ago',
      amount: '+ 10 €'
    ),

    BillingCard(
      title: 'Gastos de casa',
      date: '30 de Junio',
      statusLabel: 'Abonado: 2 Julio',
      amount: '+ 10 €'
    ),

    CustomDivider(separatorText: 'Historial (pagados)'),

    // Historial (pagada)
    PaidListCard(
      title: 'Barbacoa',
      statusLabel: 'Comprado: 24 Ago',
      amount: 'PAGADO',
      isPaid: true,
    ),

    DefaultTipText(tip: 'PARECE QUE NO QUEDAN LISTAS POR PAGAR'),
    DefaultTipText(tip: 'INICIA SESIÓN PARA PODER CREAR LISTAS COLABORATIVAS Y REPARTIR LOS GASTOS FÁCILMENTE'),
  ];
}