import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';

class LastModifiedText extends StatelessWidget {
  final DateTime updatedAt;

  const LastModifiedText({
    super.key,
    required this.updatedAt
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        _formatDate(updatedAt),
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.italic,
          color: AppColors.textSecondary,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
