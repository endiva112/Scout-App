import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';

class CustomDivider extends StatelessWidget {
  final String separatorText;

  const CustomDivider({
    super.key,
    required this.separatorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildStartContainer(context),

          const SizedBox(width: 10),

          Flexible(
            child: _buildDividerText(),
          ),

          const SizedBox(width: 10),

          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.sizeOf(context).width * 0.1,
            ),
            child: _buildFinalContainer(),
          )
        ],
      )
    );
  }

  // Contenedor inicial
  Widget _buildStartContainer(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.1,
      height: 3,
      decoration: BoxDecoration(
        color: AppColors.textTerciary,
        borderRadius: BorderRadius.circular(24)
      )
    );
  }

  // Texto
  Widget _buildDividerText() {
    return Text(
      separatorText,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textTerciary)
    );
  }

  // Contenedor final
    Widget _buildFinalContainer() {
    return Container(
      height: 3,
      decoration: BoxDecoration(
        color: AppColors.textTerciary,
        borderRadius: BorderRadius.circular(24)
      )
    );
  }
}
