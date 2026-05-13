import 'package:flutter/material.dart';

class DeleteProfileWidget extends StatelessWidget {
  const DeleteProfileWidget({super.key});

  static const String routeName = 'eliminar-perfil-menu';
  static const String routePath = '/eliminarPerfilMenu';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                color: const Color(0xFFF1F4F8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _BottomSheet(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEE8B60), Colors.white],
          stops: [0.8, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Tu perfil Scout se eliminará de manera irrecuperable y perderás todos tus datos.\n¿Seguro que deseas eliminarlo?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.normal,
                fontFamily: 'Inter',
              ),
            ),
          ),
          const SizedBox(height: 10),
          _ActionButton(
            label: 'SÍ, ELIMINAR MI PERFIL',
            backgroundColor: const Color(0xFFF1F4F8),
            textColor: const Color(0xFFEE8B60),
            onPressed: () {},
          ),
          const SizedBox(height: 10),
          _ActionButton(
            label: 'CANCELAR',
            backgroundColor: const Color(0xFFEE8B60),
            textColor: Colors.white,
            onPressed: () {},
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
  });

  final String label;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            padding: const EdgeInsets.all(16),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.normal,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ),
    );
  }
}