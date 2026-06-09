import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scout_app/core/deep_link_handler.dart';
import 'router.dart';

// Imports para Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Método main de mi app
void main() async {
  // Garantiza que el motor de Flutter esté listo antes de ejecutar
  // código nativo. Necesario siempre que hagamos await antes de runApp()
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase con la configuración generada automáticamente
  // por FlutterFire CLI para cada plataforma (Android, iOS, Web...)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Si no hay sesión activa (ni anónima ni con cuenta), crea una anónima.
  // Si ya hay sesión, Firebase la recupera automáticamente y esto no hace nada.
  if (FirebaseAuth.instance.currentUser == null) {
    await FirebaseAuth.instance.signInAnonymously();
  }

  // Arranca la app una vez Firebase está listo
  runApp(const MyApp());
}

// MiApp es el Widget principal, la raiz de toda la UI
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _deepLinkHandler = DeepLinkHandler();

  @override
  void initState() {
    super.initState();
    _deepLinkHandler.init(router);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}