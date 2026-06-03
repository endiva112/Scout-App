import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/footers/shopping_footer.dart';
import 'package:scout_app/widgets/headers/simple_list_header.dart';

class SimpleShoppingModeScreen extends StatelessWidget {
  const SimpleShoppingModeScreen({super.key});

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
              ShoppingFooter(customRoute: '/lists/simple_lists/planning')//$listId
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