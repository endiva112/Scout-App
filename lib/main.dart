import 'package:flutter/material.dart';
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

  // Arranca la app una vez Firebase está listo
  runApp(const MyApp());
}

// MiApp es el Widget principal, la raiz de toda la UI
class MyApp extends StatelessWidget {
  const MyApp({super.key}); //Constructor, usando un identificador interno que flutter comprende

  //Sin esto mi widget no sabria que pintar
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      //home: MyHomePage(titulo: 'Scout App', version: '1.0.0'),
    );
  }
}