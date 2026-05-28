import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:scout_app/widgets/bordered_container.dart';
import 'package:scout_app/widgets/footers/bottom_empty.dart';
import 'package:scout_app/widgets/headers/return_header.dart';


class ScoutOptionsScreen extends StatelessWidget {
  const ScoutOptionsScreen({super.key});

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
              ReturnHeader(),
              Expanded(child: _buildBody()),
              BottomEmpty()
            ]
          )
        )
      )
    );
  }

  Widget _buildBody() {
    return Container(
      color: AppColors.bgSecondary,
      child: Column(
        children: [

        ]
      )
    );
  }
}