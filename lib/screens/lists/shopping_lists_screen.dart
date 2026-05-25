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
              BottomNavBar(activeIndex: 0)
            ],

          ),
        ),
      ),
    );
  }
}