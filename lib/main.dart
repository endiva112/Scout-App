import 'package:flutter/material.dart';
import 'router.dart';

// Imports para Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Método main de mi app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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