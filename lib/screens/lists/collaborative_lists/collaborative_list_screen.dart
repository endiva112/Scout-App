import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';

class CollaborativeListScreen extends StatefulWidget {
  final String? listId;
  final String mode;

  const CollaborativeListScreen({
    super.key,
    this.listId,
    this.mode = 'planning',
  });

  @override
  State<CollaborativeListScreen> createState() => _CollaborativeListScreenState();
}

class _CollaborativeListScreenState extends State<CollaborativeListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: Center(
          child: Text(
            'CollaborativeListScreen - mode: ${widget.mode} - listId: ${widget.listId ?? 'nueva'}',
            style: const TextStyle(color: AppColors.textPrimary),
          ),
        ),
      ),
    );
  }
}