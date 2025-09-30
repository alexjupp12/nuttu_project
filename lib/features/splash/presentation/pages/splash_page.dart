import 'dart:async';
import 'package:flutter/material.dart';
//importamos los colores y gradientes
// import 'package:nuttu_project/app/theme/app_colors.dart';
import 'package:nuttu_project/app/theme/app_gradiants.dart';
//importamos la pagina a la que vamos a navegar
import 'package:nuttu_project/features/home/presentation/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Inicia el temporizador para navegar después de un tiempo
    _startTimer();
  }

  void _startTimer() {
    // Espera 2.5 segundos
    Timer(const Duration(milliseconds: 8000), () {
      // Navega a la página principal, reemplazando el splash screen
      // para que el usuario no pueda volver a él.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Usamos un stack para poner el texto sobre el logo si fuera necesario
      // aunque aqui un column es suficiente
      body: Container(
        // Aplicamos un gradiente de fondo
        decoration: const BoxDecoration(gradient: AppGradiants.primaryGradiant),
        child: Stack(
          children: [
            //1. el logo de la App
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/Nutu-perfil-sin-fondo.png', // Imagen del logo
                width: 250,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                //Añadimos las letras del logo para que nos quede abajo bien aliuniado
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Image.asset(
                  'assets/images/Nutu-letras.png', // Letras del logo
                  width: 120,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
