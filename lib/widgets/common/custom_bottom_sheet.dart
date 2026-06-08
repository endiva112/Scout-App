import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';

class CustomBottomSheet extends StatelessWidget {
  final Widget content;

  const CustomBottomSheet({
    super.key,
    required this.content,
  });

  static void show(BuildContext context, {required Widget content}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => CustomBottomSheet(content: content),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.actionPrimary,
                AppColors.bgPrimary,
              ],
              stops: const [0.8, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              content,
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}