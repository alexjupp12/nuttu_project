import 'package:flutter/material.dart';
import 'package:nuttu_project/features/splash/presentation/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NuTu',
      debugShowCheckedModeBanner: false, // Quita la cinta de "Debug"
      theme: ThemeData(
        // Configuraremos el tema global más adelante
        primarySwatch: Colors.blue,
      ),
      home: const SplashPage(), // <-- AQUÍ EMPIEZA LA APLICACIÓN
    );
  }
}
