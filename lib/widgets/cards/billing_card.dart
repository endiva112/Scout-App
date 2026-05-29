import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/bordered_container.dart';
import 'package:go_router/go_router.dart';

class BillingCard extends StatelessWidget {
  final String title;
  final String date;
  final String statusLabel;
  final String amount;

  const BillingCard({
    super.key,
    required this.title,
    required this.date,
    required this.statusLabel,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: () => context.push('/payments/recurring_lists/expenses'),
        child: BorderedContainer(
          backgroundColor: Theme.of(context).colorScheme.surface,
          borderColor: AppColors.listTypeRecurring,
          borderWidth: 2,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Icon(Icons.restart_alt_rounded, color: AppColors.listTypeRecurring, size: 60),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildTitle(),
                      const SizedBox(height: 5),
                      _buildDate(),
                      const SizedBox(height: 5),
                      _buildStatusRow(),
                    ]
                  )
                )
              )
            ]
          )
        )
      )
    );
  }

  Widget _buildTitle() => Text(
    title,
    maxLines: 3,
    overflow: TextOverflow.ellipsis,
    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.textPrimary, height: 1),
  );

  Widget _buildDate() => Text(
    date,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: const TextStyle(fontSize: 14, color: AppColors.textPrimary, height: 1),
  );

  Widget _buildStatusRow() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        statusLabel,
        style: const TextStyle(fontSize: 14, color: AppColors.textPrimary, height: 0.5),
      ),
      Text(
        amount,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.positive, height: 1),
      ),
    ],
  );
}