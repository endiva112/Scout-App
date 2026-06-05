import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/footers/planning_footer.dart';
import 'package:scout_app/widgets/headers/simple_list_header.dart';
import 'package:scout_app/widgets/lists/planning_body.dart';

class SimplePlanningModeScreen extends StatelessWidget {
  const SimplePlanningModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        //await _saveBeforeLeaving(); TODO similar a las notas
      },
      child: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.bgPrimary,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SimpleListHeader(),
                Expanded(child: _buildBody(context)),
                PlanningFooter(customRoute: '/lists/simple_lists/shopping')//$listId
              ]
            )
          )
        )
      )
    );
  }

  // Cuerpo de la vista
  Widget _buildBody(BuildContext context) {
    return Container(
      color: AppColors.bgSecondary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: PlanningBody(updatedAt: DateTime.now(), titleController: TextEditingController(), onChanged: () => {})//TODO Esto es temporal, hay que pasar los datos reales desde firebase
      )
    );
  }
}