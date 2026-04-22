import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// MiApp es el Widget principal, la raiz de toda la UI
class MyApp extends StatelessWidget {
  const MyApp({super.key}); //Constructor, usando un identificador interno que flutter comprende

  //Sin esto mi widget no sabria que pintar
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}