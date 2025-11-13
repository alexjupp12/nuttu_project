import 'package:flutter/material.dart';
import 'package:nuttu_project/app/theme/app_colors.dart';
// Importamos la página de Login para poder navegar a ella
import 'package:nuttu_project/features/auth/presentation/pages/login_page.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos SingleChildScrollView para evitar que el contenido se corte
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      // Usamos Center para alinear el Column, pero con CrossAxisAlignment.stretch
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          // --- AVATAR ---
          CircleAvatar(
            radius: 60,
            backgroundColor: AppColors.color4, // Tu color azul claro
            child: const Icon(Icons.person, size: 80, color: Colors.white),
          ),
          const SizedBox(height: 12),
          // --- NOMBRE DE USUARIO ---
          const Text(
            'Usuario 1',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 40),

          // --- OPCIONES DE LA LISTA ---
          // Usamos un widget auxiliar para no repetir código
          _buildListTile(
            title: 'Perfil',
            icon: Icons.person_outline,
            onTap: () {
              // Lógica para navegar a "Editar Perfil"
            },
          ),
          const Divider(indent: 20, endIndent: 20, height: 1),
          _buildListTile(
            title: 'Privacidad',
            icon: Icons.lock_outline,
            onTap: () {
              // Lógica para navegar a "Privacidad"
            },
          ),
          const Divider(indent: 20, endIndent: 20, height: 1),
          _buildListTile(
            title: 'Configuración',
            icon: Icons.settings_outlined, // <-- Nombre corregido
            onTap: () {},
          ),
          const Divider(indent: 20, endIndent: 20, height: 1),

          const SizedBox(height: 50),

          // --- BOTÓN CERRAR SESIÓN ---
          ElevatedButton(
            onPressed: () {
              // Esta es la parte importante:
              // Navegamos a la LoginPage y eliminamos todas las pantallas
              // anteriores del historial, para que el usuario no pueda
              // "volver" a la app sin iniciar sesión de nuevo.
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (Route<dynamic> route) => false, // Este predicado lo borra todo
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.color1, // Tu color morado
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            ),
            child: const Text(
              'Cerrar sesión',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget Auxiliar para los items de la lista ---
  // Esto nos ayuda a no repetir el mismo ListTile 3 veces
  Widget _buildListTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
