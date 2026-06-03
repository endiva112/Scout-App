import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/footers/planning_footer.dart';
import 'package:scout_app/widgets/headers/simple_list_header.dart';

class SimplePlanningModeScreen extends StatelessWidget {
  const SimplePlanningModeScreen({super.key});

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
              SimpleListHeader(),
              Expanded(child: _buildBody(context)),
              PlanningFooter(customRoute: '/lists/simple_lists/shopping')//$listId
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

    );
  }
}