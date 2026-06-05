import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/collections/shopping_lists_collection.dart';
import 'package:scout_app/widgets/buttons/floating_create_button.dart';
import 'package:scout_app/widgets/common/custom_bottom_sheet.dart';
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
        Expanded(child: ShoppingListsCollection()),
      ],
    );
  }

  void _showCreateSheet(BuildContext context) {
    CustomBottomSheet.show(
      context,
      content: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              context.push('/lists/simple_list');
            },
            child: const Text('Lista simple'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              context.push('/lists/collaborative_list');
            },
            child: const Text('Lista colaborativa'),
          ),
        ],
      ),
    );
  }
}