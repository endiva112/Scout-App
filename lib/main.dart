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
    return MaterialApp(
      home: MyHomePage(titulo: 'Scout App', version: '1.0.0'),
    );
  }
}

// Scaffold
// Es solo la cáscara del widget. Aquí van los parámetros que le pasas desde fuera
class MyHomePage extends StatefulWidget {
  final String titulo;
  final String version;

    const MyHomePage({super.key, required this.titulo, required this.version});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Contenido
// Aquí vive todo lo demás: los datos internos que cambian (_counter), la lógica, y el build(). 
//El guión bajo del principio _ significa que es privada — solo accesible dentro de este archivo.
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${widget.titulo} v${widget.version}'),
              Text('$_counter'),
            ],
          ),
        ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _counter++;
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}