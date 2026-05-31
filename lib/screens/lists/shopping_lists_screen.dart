import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/collections/shopping_lists_collection.dart';
import 'package:scout_app/widgets/buttons/floating_create_button.dart';

import 'package:scout_app/widgets/headers/main_header.dart';
import 'package:scout_app/widgets/simple_title.dart';
import 'package:scout_app/widgets/footers/bottom_navbar.dart';


class ShoppingListsScreen extends StatelessWidget {
  const ShoppingListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          FloatingCreateButton(onTap: () {})
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
        Expanded(child: ShoppingListsCollection())
      ]
    );
  }
}