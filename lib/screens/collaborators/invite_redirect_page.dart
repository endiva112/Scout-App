import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:scout_app/repositories/lists/invitation_repository.dart';

class InviteRedirectPage extends StatefulWidget {
  final String listId;
  final String token;

  const InviteRedirectPage({
    super.key,
    required this.listId,
    required this.token,
  });

  @override
  State<InviteRedirectPage> createState() => _InviteRedirectPageState();
}

class _InviteRedirectPageState extends State<InviteRedirectPage> {
  @override
  void initState() {
    super.initState();
    _redeem();
  }

  Future<void> _redeem() async {
    final user = FirebaseAuth.instance.currentUser;

    // Si no hay usuario anónimo todavía (caso extremo), lo creamos
    final effectiveUser = user ?? 
        (await FirebaseAuth.instance.signInAnonymously()).user!;

    final repo = InvitationRepository();
    final success = await repo.redeemInvitation(
      listId: widget.listId,
      token: widget.token,
      userId: effectiveUser.uid,
    );

    if (!mounted) return;

    if (success) {
      // Navegar a la lista recién unida
      context.go('/lists/collaborative_list/${widget.listId}');
    } else {
      // Token inválido, expirado o ya usado → volver al inicio con aviso
      context.go('/');
      _showInvalidTokenSnackbar();
    }
  }

  void _showInvalidTokenSnackbar() {
    // Usamos addPostFrameCallback porque la página de destino
    // ya habrá hecho su build cuando lleguemos aquí
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El enlace de invitación no es válido o ha caducado.'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Pantalla de transición mientras se procesa
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}