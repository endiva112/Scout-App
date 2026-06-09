import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/common/bordered_container.dart';
//import 'package:go_router/go_router.dart';

class _PaidListCardStyle {
  final Color borderColor;
  final Color iconColor;
  final Color titleColor;
  final Color textColor;
  final Color amountColor;
  final Color backgroundColor;

  const _PaidListCardStyle({
    required this.borderColor,
    required this.iconColor,
    required this.titleColor,
    required this.textColor,
    required this.amountColor,
    required this.backgroundColor,
  });
}

const _activeStyle = _PaidListCardStyle(
  borderColor: AppColors.listTypeCollaborative,
  iconColor: AppColors.listTypeCollaborative,
  titleColor: AppColors.textPrimary,
  textColor: AppColors.textPrimary,
  amountColor: AppColors.negative,
  backgroundColor: AppColors.bgPrimary,
);

const _paidStyle = _PaidListCardStyle(
  borderColor: AppColors.bgTerciary,
  iconColor: AppColors.textTerciary,
  titleColor: AppColors.textTerciary,
  textColor: AppColors.textTerciary,
  amountColor: AppColors.textTerciary,
  backgroundColor: AppColors.bgTerciary,
);

class PaidListCard extends StatelessWidget {
  final String title;
  final String statusLabel;
  final String amount;
  final bool isPaid;

  // callbacks para acciones del menú
  final VoidCallback? onReuse;
  final VoidCallback? onDelete;

  const PaidListCard({
    super.key,
    required this.title,
    required this.statusLabel,
    required this.amount,
    this.isPaid = false,
    this.onReuse,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final style = isPaid ? _paidStyle : _activeStyle;

    return GestureDetector(
      onLongPressStart: isPaid
          ? (details) => _showMenu(context, details)
          : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BorderedContainer(
          backgroundColor: style.backgroundColor,
          borderColor: style.borderColor,
          borderWidth: 2,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Icon(
                  Icons.groups_2_rounded,
                  color: style.iconColor,
                  size: 60,
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 20, top: 10, bottom: 10),
                  child: InkWell(
                    onTap: () => {}, // TODO modificar, que las que esten en pendientes de pago lleven a un sitio y las que estan en el historial lleven a otro o a ningun sitio
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildTitle(style),
                        const SizedBox(height: 5),
                        _buildStatusRow(style),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMenu(BuildContext context, LongPressStartDetails details) async {
    final value = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx,
        details.globalPosition.dy,
      ),
      items: [
        const PopupMenuItem(
          value: 'reuse',
          child: ListTile(
            dense: true,
            title: Text('Reutilizar lista'),
            trailing: Icon(Icons.repeat_on_rounded),
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
          ),
        ),
        const PopupMenuItem(
          value: 'delete',
          height: 40,
          child: ListTile(
            dense: true,
            title: Text(
              'Eliminar lista',
              style: TextStyle(color: AppColors.negative),
            ),
            trailing:
                Icon(Icons.delete_outline, color: AppColors.negative),
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
          ),
        ),
      ],
    );

    switch (value) {
      case 'reuse':
        onReuse?.call();
        break;
      case 'delete':
        onDelete?.call();
        break;
    }
  }

  Widget _buildTitle(_PaidListCardStyle style) => Text(
    title,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: style.titleColor,
      height: 1,
    ),
  );

  Widget _buildStatusRow(_PaidListCardStyle style) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        statusLabel,
        style: TextStyle(
          fontSize: 14,
          color: style.textColor,
          height: 0,
        ),
      ),
      Text(
        amount,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: style.amountColor,
          height: 1.25,
        ),
      ),
    ],
  );
}