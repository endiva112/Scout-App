import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/collections/lists/shopping_lists_collection.dart';
import 'package:scout_app/widgets/buttons/floating_create_button.dart';
import 'package:scout_app/widgets/common/custom_bottom_sheet.dart';
import 'package:scout_app/widgets/common/sheet_option.dart';
import 'package:scout_app/widgets/headers/main_header.dart';
import 'package:scout_app/widgets/common/simple_title.dart';
import 'package:scout_app/widgets/footers/bottom_navbar.dart';
import 'package:go_router/go_router.dart';

class ShoppingListsScreen extends StatelessWidget {
  const ShoppingListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MainHeader(),
            Expanded(child: _buildBody(context)),
            BottomNavBar(activeIndex: 0),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      color: AppColors.bgSecondary,
      child: Stack(
        children: [
          _buildBodyContent(),
          FloatingCreateButton(onTap: () => _showCreateSheet(context)),
        ],
      ),
    );
  }

  Widget _buildBodyContent() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SimpleTitle(title: 'Listas activas'),
        // Invoco mi colección de listas con estado -- shopping --
        Expanded(child: ShoppingListsCollection()),
      ],
    );
  }

  void _showCreateSheet(BuildContext context) {
    CustomBottomSheet.show(
      context,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Nueva lista',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 24),
          SheetOption(
            icon:  Icons.list_rounded,
            title:  'Lista simple',
            subtitle:  'Solo para ti',
            onTap: () {
              Navigator.pop(context);
              context.push('/lists/simple_list');
            },
          ),
          const SizedBox(height: 12),
          SheetOption(
            icon: Icons.group_rounded,
            title: 'Lista colaborativa',
            subtitle: 'Para compras en grupo y reparto de gastos',
            onTap: () {
              Navigator.pop(context);
              context.push('/lists/collaborative_list');
            },
          ),
          const SizedBox(height: 12),
          SheetOption(
            icon: Icons.group_rounded,
            title: 'Lista recurrente',
            subtitle: 'Para gastos recurrentes entre compañeros',
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Función no implementada')),
              );
            },
          )
        ],
      ),
    );
  }
}
