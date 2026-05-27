import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/custom_divider.dart';
import 'package:scout_app/widgets/default_tip_text.dart';
import 'package:scout_app/widgets/buttons/floating_create_button.dart';
import 'package:scout_app/widgets/cards/list_card.dart';

import 'package:scout_app/widgets/headers/main_header.dart';
import 'package:scout_app/widgets/simple_title.dart';
import 'package:scout_app/widgets/footers/bottom_navbar.dart';


class ShoppingListsScreen extends StatelessWidget {
  const ShoppingListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.bgPrimary,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            // Componentes de esta página
            children: [
              MainHeader(),
              Expanded(child: _buildBody(context)),
              BottomNavBar(activeIndex: 0)
            ]
          )
        )
      )
    );
  }

  // Cuerpo de la vista
  Widget _buildBody(BuildContext context) {
    return Container(
      color: AppColors.bgSecondary,
      child: Stack(
        children: [
          //Listado de listas de la compra
          _buildBodyContent(),

          //Botón de creación de lista
          FloatingCreateButton()
        ]
      )
    );
  }

  // Cuerpo del listado de listas de la compra
  Widget _buildBodyContent() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SimpleTitle(title: 'Listas activas'),
        Expanded(child: _buildShoppingListsCollection())
      ]
    );
  }

  // Listado DINÁMICO de listas. COMPONENTE MÁS IMPORTANTE DE ESTA VISTA
  Widget _buildShoppingListsCollection() {
    final widgets = [
      CustomDivider(separatorText: 'Mis listas'),

      ListCard(type: ListType.simple, title: 'Gastos de la casa', items: 6, extraInfo: '3 tiendas', listId: 'zmZYM6O1aWkWdL3pnai8'),

      ListCard(type: ListType.collaborative, title: 'Barbacoa', items: 2, extraInfo: 'Lidl', listId: 'zmZYM6O1aWkWdL3pnai8'),

      ListCard(type: ListType.recurring, title: 'Pago del piso de Huelva', items: 6, extraInfo: '10 días para el cobro', listId: 'zmZYM6O1aWkWdL3pnai8'),

      ListCard(type: ListType.recurring, title: 'Pago del piso de Sevilla', items: 6, extraInfo: 'DESACTIVADA', listId: 'zmZYM6O1aWkWdL3pnai8'),

      ListCard(type: ListType.simple, title: 'Gastos de casa de esos que tienen el nombre exageradamente largo y que rompen la UI', items: 6, extraInfo: '3 tiendas', listId: 'zmZYM6O1aWkWdL3pnai8'),

      CustomDivider(separatorText:'Mis listas Mis listas Mis listas Mis listas'),

      DefaultTipText(tip: 'CREA LISTAS DE LA COMPRA, LISTAS COLABORATIVAS O GASTOS RECURRENTES'),
    ];

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 150),
      itemCount: widgets.length,

      itemBuilder: (context, index) {
        return widgets[index];
      },

      separatorBuilder: (context, index) {
        return const SizedBox(height: 10);
      },
    );
  }
}