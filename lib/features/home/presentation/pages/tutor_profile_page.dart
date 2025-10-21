import 'package:flutter/material.dart';
import 'package:nuttu_project/features/home/domain/models/tutor_model.dart';
import 'package:nuttu_project/app/theme/app_colors.dart';

class TutorProfilePage extends StatelessWidget {
  // Recibimos el objeto Tutor para saber qué info mostrar
  final Tutor tutor;
  const TutorProfilePage({super.key, required this.tutor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Usamos un Stack para poner el botón de "volver" encima de la imagen
      body: Stack(
        children: [
          // 1. Contenido principal con Scroll
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 20)),
                // --- IMAGEN DE PERFIL ---
                Image.asset(
                  tutor.avatarUrl,
                  width: double.infinity,
                  height: 400, // Ajusta la altura como prefieras
                  fit: BoxFit.cover,
                ),

                // --- BLOQUE DE INFORMACIÓN ---
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tutor.nombre,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.color1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'ID: ${tutor.id}',
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Tutor: ${tutor.materia}',
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'Calificación: 4,2',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            '🌟',
                            style: TextStyle(fontSize: 16),
                          ), // Emoji de estrella
                        ],
                      ),
                    ],
                  ),
                ),

                // --- SECCIÓN DE "POST" ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const Divider(thickness: 1),
                      Text(
                        'POST',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: Colors.grey[800],
                        ),
                      ),
                      const Divider(thickness: 1),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // --- Cuadrícula de Posts (mostrando 1 estático) ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  // !! IMPORTANTE: Añade esta imagen 'post_selfie.png' a tu carpeta 'assets/images/'
                  child: Image.asset(
                    'assets/images/post_selfie.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Espacio al final para que no tape los botones
                const SizedBox(height: 120),
              ],
            ),
          ),

          // --- BOTÓN DE VOLVER (Sobre la imagen) ---
          Positioned(
            top: 40.0, // Distancia desde arriba
            left: 10.0,
            child: SafeArea(
              child: CircleAvatar(
                backgroundColor: Colors.black.withAlpha(
                  120,
                ), // Fondo semi-transparente
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () => Navigator.of(
                    context,
                  ).pop(), // Vuelve a la pantalla anterior
                ),
              ),
            ),
          ),
        ],
      ),

      // --- BOTONES INFERIORES FIJOS ---
      bottomNavigationBar: Padding(
        // Padding para que no queden pegados al borde
        padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Botón "Seguir"
            ElevatedButton.icon(
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                'Seguir',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onPressed: () {
                /* Lógica para seguir */
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.color4, // Azul de tu paleta
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
              ),
            ),
            // Botón "Contratar"
            OutlinedButton.icon(
              icon: Icon(Icons.edit_calendar, color: AppColors.color1),
              label: Text(
                'Contratar',
                style: TextStyle(color: AppColors.color1, fontSize: 18),
              ),
              onPressed: () {
                /* Lógica para contratar */
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: AppColors.color1,
                  width: 2,
                ), // Borde de tu color principal
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
