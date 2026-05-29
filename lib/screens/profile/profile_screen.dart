import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';

import 'package:scout_app/widgets/footers/bottom_navbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,

          // Componentes de esta página
          children: [
            Text('Perfil', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: AppColors.textPrimary)),
            Expanded(child: _buildBody()),
            BottomNavBar(activeIndex: -1)
          ]
        )
      )
    );
  }

  Widget _buildBody() {
    bool condicion = true;
    if (condicion) {
      return Container();
      //return WidgetCustom();
    } else {
      return Row();
      //return WidgetCustom2();
    }
  }
}