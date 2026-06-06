import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';

class SimpleListScreen extends StatefulWidget {
  final String? listId;
  final String mode;

  const SimpleListScreen({
    super.key,
    this.listId,
    this.mode = 'planning',
  });

  @override
  State<SimpleListScreen> createState() => _SimpleListScreenState();
}

class _SimpleListScreenState extends State<SimpleListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: Center(
          child: Text(
            'SimpleListScreen - mode: ${widget.mode} - listId: ${widget.listId ?? 'nueva'}',
            style: const TextStyle(color: AppColors.textPrimary),
          ),
        ),
      ),
    );
  }
}