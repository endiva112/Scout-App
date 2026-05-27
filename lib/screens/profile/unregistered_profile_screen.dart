import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';

import 'package:scout_app/widgets/footers/bottom_navbar.dart';

class UnregisteredProfileScreen extends StatelessWidget {
  const UnregisteredProfileScreen({super.key});

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
              
              //TODO

              BottomNavBar(activeIndex: -1)
            ]
          )
        )
      )
    );
  }
}