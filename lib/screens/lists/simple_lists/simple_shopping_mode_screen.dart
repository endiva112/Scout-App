import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/footers/shopping_footer.dart';
import 'package:scout_app/widgets/headers/simple_list_header.dart';

class SimpleShoppingModeScreen extends StatefulWidget {
  final String listId;

  const SimpleShoppingModeScreen({
    super.key,
    required this.listId,
  });

  @override
  State<SimpleShoppingModeScreen> createState() => _SimpleShoppingModeScreenState();
}

class _SimpleShoppingModeScreenState extends State<SimpleShoppingModeScreen> {
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
            children: [
              SimpleListHeader(
                onBeforeReturn: () async {},
              ),
              Expanded(child: _buildBody()),
              ShoppingFooter(
                customRoute: '/lists/simple_list/${widget.listId}',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      color: AppColors.bgSecondary,
    );
  }
}