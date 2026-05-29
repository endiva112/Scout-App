import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
//TODO import 'package:scout_app/widgets/custom_divider.dart';
//TODO import 'package:scout_app/widgets/default_tip_text.dart';

import 'package:scout_app/widgets/headers/main_header.dart';
//TODO import 'package:scout_app/widgets/simple_title.dart';
import 'package:scout_app/widgets/footers/bottom_navbar.dart';

class PurchasedListsScreen extends StatelessWidget {
  const PurchasedListsScreen({super.key});

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
            
            //TODO

            BottomNavBar(activeIndex: 1)
          ]
        )
      )
    );
  }
}