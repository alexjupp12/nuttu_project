import 'package:flutter/material.dart';
import 'package:nuttu_project/app/theme/app_colors.dart';
import 'package:nuttu_project/features/home/presentation/pages/cursos_page.dart';
import 'package:nuttu_project/features/home/presentation/pages/home_page.dart'; // Tu HomePage original
import 'package:nuttu_project/features/home/presentation/pages/perfil_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 1; // Empezamos en la pestaña de Inicio (índice 1)

  // Lista de las páginas que se mostrarán
  static const List<Widget> _pages = <Widget>[
    CursosPage(), // Índice 0
    HomePage(), // Índice 1
    PerfilPage(), // Índice 2
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // La AppBar ahora vive aquí
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 1,
        title: Image.asset('assets/images/Nutu-letras.png', height: 50),
        actions: [
          IconButton(
            icon: Image.asset('assets/images/Chats.png', width: 35),
            onPressed: () {},
          ),
          const SizedBox(width: 15),
        ],
      ),
      // El cuerpo cambia según el índice seleccionado
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            // Ícono para el estado normal/no seleccionado
            icon: Image.asset('assets/images/Tutorias.png', width: 24),
            // Ícono para el estado activo/seleccionado
            activeIcon: Image.asset(
              'assets/images/TutoriasCambio.png',
              width: 32,
            ),
            label: 'Tutorias',
          ),
          BottomNavigationBarItem(
            // Ícono para el estado normal/no seleccionado
            icon: Image.asset('assets/images/Casa.png', width: 24),
            // Ícono para el estado activo/seleccionado
            activeIcon: Image.asset('assets/images/CasaColor.png', width: 32),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            // Ícono para el estado normal/no seleccionado
            icon: Image.asset('assets/images/Nutu-perfil-gris.png', width: 27),
            // Ícono para el estado activo/seleccionado
            activeIcon: Image.asset(
              'assets/images/Nutu-perfil-color.png',
              width: 36,
            ),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.color1,
        onTap: _onItemTapped, // Llama a nuestra función para cambiar de página
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15, // Tamaño para la etiqueta seleccionada
        ),
      ),
    );
  }
}
