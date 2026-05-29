import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/bordered_container.dart';

enum PaidListType {
  recurring,
  collaborative,
}

class _PaidListCardStyle {
  final Color borderColor;
  final IconData icon;

  const _PaidListCardStyle({
    required this.borderColor,
    required this.icon,
  });
}

const _cardStyles = {
  PaidListType.recurring: _PaidListCardStyle(
    borderColor: AppColors.listTypeRecurring,
    icon: Icons.restart_alt_rounded,
  ),
  PaidListType.collaborative: _PaidListCardStyle(
    borderColor: AppColors.listTypeCollaborative,
    icon: Icons.groups_2_rounded,
  ),
};

class PaidListCard extends StatelessWidget {
  final PaidListType type;
  final String title;
  final String date;
  final String statusLabel;
  final String? amount;   // null si no aplica (ej: "POR ABONAR!")
  final bool isPaid;      // true = estilo historial (grisado)

  const PaidListCard({
    super.key,
    required this.type,
    required this.title,
    required this.date,
    required this.statusLabel,
    this.amount,
    this.isPaid = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = _cardStyles[type]!;

    final Color activeColor = isPaid ? AppColors.textSecondary : style.borderColor;
    final Color bgColor = isPaid
        ? Theme.of(context).colorScheme.surfaceVariant
        : Theme.of(context).colorScheme.surface;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: BorderedContainer(
        backgroundColor: bgColor,
        borderColor: isPaid ? bgColor : style.borderColor,
        borderWidth: 2,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Icon(style.icon, color: activeColor, size: 60),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTitle(activeColor),
                    const SizedBox(height: 5),
                    _buildDateRow(context),
                    const SizedBox(height: 5),
                    _buildStatusRow(context, activeColor),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(Color color) {
    return Text(
      title,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );
  }

  Widget _buildDateRow(BuildContext context) {
    return Text(
      date,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 14,
        color: isPaid ? AppColors.textSecondary : AppColors.textPrimary,
      ),
    );
  }

  Widget _buildStatusRow(BuildContext context, Color accentColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            statusLabel,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              color: isPaid ? AppColors.textSecondary : AppColors.textPrimary,
            ),
          ),
        ),
        if (amount != null)
          Text(
            amount!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isPaid ? AppColors.textSecondary : accentColor,
            ),
          ),
      ],
    );
  }
}