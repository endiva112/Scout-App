import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/collections/lists/purchased_lists_collection.dart';
import 'package:scout_app/widgets/headers/main_header.dart';
import 'package:scout_app/widgets/common/simple_title.dart';
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
            Expanded(child: _buildBody(context)),
            BottomNavBar(activeIndex: 1)
          ]
        )
      )
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      color: AppColors.bgSecondary,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SimpleTitle(title: 'Listas por pagar'),
          _buildSummary(0),// TODO calcular el valor real
          Expanded(
            child: PurchasedListsCollection()
          )
        ]
      )
    );
  }

  Widget _buildSummary(int balance) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Saldo estimado: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: AppColors.textPrimary)),
            Text('$balance €', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary))
          ]
        ),
        Divider(
          thickness: 2,
          indent: 20,
          endIndent: 20,
          color: AppColors.bgTerciary,
        )
      ],
    );
  }
}