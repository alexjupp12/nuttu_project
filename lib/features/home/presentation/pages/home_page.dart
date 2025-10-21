import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:nuttu_project/app/theme/app_colors.dart';
import 'package:nuttu_project/features/home/domain/models/tutor_model.dart';
// ¡CAMBIO AQUÍ! Importamos la página de perfil
import 'package:nuttu_project/features/home/presentation/pages/tutor_profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentCarouselIndex = 0;
  late final PageController _pageController;
  Timer? _timer;

  final List<String> _carouselImages = [
    'assets/images/publicidad02.png',
    'assets/images/publicidad01.png',
    'assets/images/publicidad03.png',
  ];

  final List<Tutor> _tutores = [
    Tutor(
      nombre: 'JuanDa Higuita',
      materia: 'Inglés, Español', // Modificado para incluir Español
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
      materia: 'Mátematicas, Programación',
      edad: 24,
      id: '0-123456789',
      avatarUrl: 'assets/images/Walther.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted) return;
      int nextPage = _currentCarouselIndex < _carouselImages.length - 1
          ? _currentCarouselIndex + 1
          : 0;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Este widget ahora solo devuelve el contenido, sin Scaffold.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        // --- CARRUSEL CON PAGEVIEW ---
        SizedBox(
          height: 280,
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
              return _buildTutorCard(context, tutor); // Pasamos 'context'
            },
          ),
        ),
      ],
    );
  }

  // ¡CAMBIO AQUÍ! Añadimos el InkWell y el context
  Widget _buildTutorCard(BuildContext context, Tutor tutor) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TutorProfilePage(tutor: tutor),
          ),
        );
      },
      child: Card(
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
      ),
    );
  }
}
