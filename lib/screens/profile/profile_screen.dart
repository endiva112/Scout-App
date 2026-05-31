import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';

import 'package:scout_app/widgets/footers/bottom_navbar.dart';
import 'package:scout_app/widgets/profile/anonympus_profile_content.dart';
import 'package:scout_app/widgets/profile/registered_profile_content.dart';

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
            Padding(
              padding: const EdgeInsetsGeometry.only(top: 20),
              child: Text('Perfil', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: AppColors.textPrimary)),
            ),
            Expanded(child: _buildBody(false)),  //TODO reemplazar por lógica real
            BottomNavBar(activeIndex: -1)
          ]
        )
      )
    );
  }

  Widget _buildBody(bool isAnonymous) {
    if (isAnonymous) {
      return AnonympusProfileContent();
    } else {
      return RegisteredProfileContent();
    }
  }
}