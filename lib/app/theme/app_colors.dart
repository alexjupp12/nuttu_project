import 'package:flutter/material.dart';

// creación de una clase, para no tener que realizar instancias.
// Buscamos acceder a los colores de forma estática.

class AppColors {
  //evitamos que alguiien pueda instanciar la clase
  AppColors._();

  // PALETA PRINCIPAL
  static const Color color1 = Color(0xFF877DD3);
  static const Color color2 = Color(0xFFC9B0E7);
  static const Color color3 = Color(0xFFFEDEEB);
  static const Color color4 = Color(0xFF84BBD0);
  static const Color color5 = Color(0xFF5578D8);
  static const Color colorDark = Color.fromARGB(255, 10, 22, 54);
  static const Color facebookBlue = Color.fromARGB(255, 6, 34, 110);

  // COLORES NEUTROS
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF9E9E9E);

  // COLORES DE ALERTA O ESTADO
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFF44336);
}
