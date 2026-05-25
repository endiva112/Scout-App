import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 70),
      color: AppColors.bgPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGreetingMessage(),
              _buildUserName()
            ]
          ),

          // Acceso al perfil del usuario
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => context.go('/profile'),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(
                  'https://picsum.photos/seed/758/600',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover
                )
              )
            )
          )

        ],
      )
    );
  }
}

// Saludar al usuario dependiendo de la hora del dispositivo
Widget _buildGreetingMessage() {
  final hour = DateTime.now().hour;
  String message;
  if (hour < 12) {
    message = 'Buenos días!';
  } if (hour < 20) {
    message = 'Buenas tardes!';
  } else {
    message = 'Buenas noches!';
  }

  return Text(
    message
  );
}

// Obtener el nombre del usuario desde firebase
Widget _buildUserName() {
  final user = FirebaseAuth.instance.currentUser!; // ! porque NUNCA debería ser null. daría un pete, para evitar futuros problemas
  String userName;

  if (user.isAnonymous) { // Si es anónimo
    userName = 'Scout_${user.uid.substring(0, 6).toUpperCase()}';
  } else {  // Si tiene cuenta vinculada
    // El nombre que muestra es su alias o si no tiene, pues lo mismo que el usuario anónimo
    userName = user.displayName ?? 'Scout_${user.uid.substring(0, 6).toUpperCase()}';
  }

  return Text(userName);
}