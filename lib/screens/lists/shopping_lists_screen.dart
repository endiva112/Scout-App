import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';

import 'package:scout_app/widgets/bottom_navbar.dart';
import 'package:scout_app/widgets/main_header.dart';

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
            ],

          ),
        ),
      ),
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
          _buildAddButton()
        ]
      )
    );
  }

  //Listado de listas de la compra
  Widget _buildBodyContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
    );
  }

  // Botón de creación de lista
  Widget _buildAddButton() {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.actionPrimary,
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 48),
        )
      )
    );
  }
}