import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/bordered_container.dart';
import 'package:scout_app/widgets/collections/languages_collection.dart';
import 'package:scout_app/widgets/footers/bottom_empty.dart';
import 'package:scout_app/widgets/headers/return_header.dart';

class SetLanguageScreen extends StatelessWidget {
  const SetLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ReturnHeader(),
            _buildBody(context),
            BottomEmpty()
          ]
        )
      )
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: _buildOptions(context),
    );
  }

  Widget _buildOptions(BuildContext context) {
    return BorderedContainer(
      borderWidth: 1,
      borderColor: AppColors.bgSecondary,
      backgroundColor: AppColors.bgSecondary,
      elevation: 0,
      child: LanguagesCollection()
    );
  }
}