import 'dart:async'; // Importante para el Timer
import 'package:flutter/material.dart';
import 'package:nuttu_project/app/theme/app_colors.dart';
import 'package:nuttu_project/features/home/domain/models/tutor_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // --- ESTADO DE LA PANTALLA ---
  int _currentCarouselIndex = 0;
  int _bottomNavIndex = 1;

  // Controlador para el PageView, nos permite controlarlo con código
  late final PageController _pageController;
  // Timer para el auto-scroll
  Timer? _timer;

  final List<String> _carouselImages = [
    'assets/images/publicidad-01.png',
    'assets/images/publicidad-02.png',
    'assets/images/publicidad-03.png',
  ];

  final List<Tutor> _tutores = [
    Tutor(
      nombre: 'Carlos Gutierrez',
      materia: 'Inglés',
      edad: 22,
      id: '0-132131241',
      avatarUrl: 'assets/images/Carlos.png',
    ),
    Tutor(
      nombre: 'Alejandra Tejada',
      materia: 'Bioquímica',
      edad: 26,
      id: '0-194184192',
      avatarUrl: 'assets/images/Alejandra.png',
    ),
    Tutor(
      nombre: 'Walther Zapata',
      materia: 'Matemáticas',
      edad: 24,
      id: '0-123456789',
      avatarUrl: 'assets/images/Walther.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Inicializamos el PageController
    _pageController = PageController(viewportFraction: 0.85);
    // Iniciamos el Timer para el auto-scroll
    _startTimer();
  }

  // Método para iniciar el Timer
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentCarouselIndex < _carouselImages.length - 1) {
        _currentCarouselIndex++;
      } else {
        _currentCarouselIndex = 0;
      }
      // Animamos el PageView a la siguiente página
      _pageController.animateToPage(
        _currentCarouselIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    // Es MUY importante cancelar el timer y liberar el controller
    // para evitar fugas de memoria.
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 1,
        title: Image.asset('assets/images/Nutu-letras.png', height: 35),
        actions: [
          IconButton(
            icon: Image.asset('assets/images/Chats.png', width: 30),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          // --- NUESTRO CARRUSEL CON PAGEVIEW ---
          SizedBox(
            height: 250,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _carouselImages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentCarouselIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(_carouselImages[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          // --- INDICADORES DEL CARRUSEL (PUNTOS) ---
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _carouselImages.asMap().entries.map((entry) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 4.0,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withAlpha(
                    _currentCarouselIndex == entry.key ? 230 : 102,
                  ),
                ),
              );
            }).toList(),
          ),
          // --- TÍTULO "EXPLORAR" ---
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'EXPLORAR',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          // --- LISTA DE TUTORES ---
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: _tutores.length,
              itemBuilder: (context, index) {
                final tutor = _tutores[index];
                return _buildTutorCard(tutor);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Cursos',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        selectedItemColor: AppColors.color1, // Usando tu nueva paleta
      ),
    );
  }

  Widget _buildTutorCard(Tutor tutor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage(tutor.avatarUrl),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tutor.nombre,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Tutor: ${tutor.materia}'),
                  Text('Edad: ${tutor.edad} años'),
                  Text(
                    'ID: ${tutor.id}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
