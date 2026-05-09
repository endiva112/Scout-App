import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthSandboxScreen extends StatefulWidget {
  const AuthSandboxScreen({super.key});

  @override
  State<AuthSandboxScreen> createState() => _AuthSandboxScreenState();
}

class _AuthSandboxScreenState extends State<AuthSandboxScreen> {
  final _auth = FirebaseAuth.instance;
  bool _cargando = false;
  String? _error;

  // ─── ACCIONES ────────────────────────────────────────────────────────────────

  Future<void> _loginAnonimo() async {
    setState(() { _cargando = true; _error = null; });
    try {
      await _auth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      setState(() => _error = e.message);
    } finally {
      setState(() => _cargando = false);
    }
  }

  Future<void> _logout() async {
    setState(() { _cargando = true; _error = null; });
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      setState(() => _error = e.message);
    } finally {
      setState(() => _cargando = false);
    }
  }

  // ─── UI ──────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auth Sandbox')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // ── BLOQUE: estado actual ──────────────────────────────────────────
            // StreamBuilder escucha authStateChanges en tiempo real.
            // Se reconstruye automáticamente cuando el usuario se loguea o desloguea.
            // Equivalente exacto al StreamBuilder de snapshots() en tu sandbox de Firestore.
            StreamBuilder<User?>(
              stream: _auth.authStateChanges(),
              builder: (context, snapshot) {

                // Mientras Firebase inicializa, muestra loading
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const _InfoCard(
                    color: Colors.grey,
                    titulo: 'Estado',
                    contenido: 'Conectando con Firebase...',
                  );
                }

                final user = snapshot.data;

                // No hay usuario autenticado
                if (user == null) {
                  return const _InfoCard(
                    color: Colors.red,
                    titulo: 'Estado',
                    contenido: 'Sin autenticar\n\nNo hay usuario activo.',
                  );
                }

                // Hay usuario autenticado
                // user.isAnonymous → true si es anónimo, false si tiene email/Google/etc.
                return _InfoCard(
                  color: Colors.green,
                  titulo: 'Estado',
                  contenido:
                    'Autenticado ✓\n\n'
                    'UID: ${user.uid}\n\n'
                    'Tipo: ${user.isAnonymous ? "Anónimo" : "Con cuenta"}\n\n'
                    'Email: ${user.email ?? "(ninguno)"}\n\n'
                    // creationTime es cuándo se creó la sesión por primera vez.
                    // Si reinicias la app y el uid es el mismo, creationTime no cambia.
                    // Así puedes verificar que la sesión persiste.
                    'Sesión creada: ${user.metadata.creationTime?.toLocal() ?? "—"}',
                );
              },
            ),

            const SizedBox(height: 24),

            // ── BLOQUE: error ──────────────────────────────────────────────────
            if (_error != null)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(_error!, style: const TextStyle(color: Colors.red)),
              ),

            // ── BLOQUE: acciones ───────────────────────────────────────────────
            if (_cargando)
              const Center(child: CircularProgressIndicator())
            else ...[

              // signInAnonymously() crea un usuario anónimo si no hay sesión activa.
              // Si ya hay sesión, Firebase la mantiene (no crea una nueva).
              ElevatedButton(
                onPressed: _loginAnonimo,
                child: const Text('Login anónimo'),
              ),

              const SizedBox(height: 12),

              // signOut() cierra la sesión local.
              // La próxima vez que hagas signInAnonymously() obtendrás un UID DISTINTO.
              // Úsalo para entender que "logout" en anónimo = perder identidad.
              OutlinedButton(
                onPressed: _logout,
                child: const Text('Logout'),
              ),
            ],

            const Spacer(),
            TextButton(
              onPressed: () => context.go('/'),
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── WIDGET AUXILIAR ─────────────────────────────────────────────────────────

class _InfoCard extends StatelessWidget {
  final Color color;
  final String titulo;
  final String contenido;

  const _InfoCard({
    required this.color,
    required this.titulo,
    required this.contenido,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo.toUpperCase(),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(contenido, style: const TextStyle(fontFamily: 'monospace')),
        ],
      ),
    );
  }
}