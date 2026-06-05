import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/common/bordered_container.dart';

class AddGroupButton extends StatelessWidget {

  const AddGroupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        
      },
      child: BorderedContainer(
        borderColor: AppColors.bgTerciary,
        borderWidth: 2,
        elevation: 2,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsetsGeometry.symmetric(vertical: 20),
              child: Text('AGREGAR TIENDA', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500, color: AppColors.textTerciary, height: 1))
            )
          ]
        )
      )
    );
  }
}