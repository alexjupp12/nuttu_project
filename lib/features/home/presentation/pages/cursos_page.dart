import 'package:flutter/material.dart';
import 'package:nuttu_project/app/theme/app_colors.dart';
// Importamos el modelo de Tutor que ya teníamos
import 'package:nuttu_project/features/home/domain/models/tutor_model.dart';
// ¡CAMBIO AQUÍ! Importamos la página de perfil
import 'package:nuttu_project/features/home/presentation/pages/tutor_profile_page.dart';

class CursosPage extends StatefulWidget {
  // 1. Convertido a StatefulWidget
  const CursosPage({super.key});

  @override
  State<CursosPage> createState() => _CursosPageState();
}

class _CursosPageState extends State<CursosPage> {
  // 2. Controladores y estado para la búsqueda
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<Tutor> _allTutors = [];
  List<Tutor> _filteredTutors = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    // 3. Creamos nuestra "base de datos" de tutores
    _allTutors = [
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
      Tutor(
        nombre: 'Daniela Diaz',
        materia: 'Canto',
        edad: 24,
        id: '0-001123234',
        avatarUrl: 'assets/images/Daniela.png',
      ),
      // Puedes añadir más tutores aquí
    ];

    // 4. Añadimos un listener al controlador
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  // 5. Métodos para manejar la búsqueda
  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
      _isSearching = _searchQuery.isNotEmpty;
      _filterTutors();
    });
  }

  void _filterTutors() {
    if (!_isSearching) {
      _filteredTutors = [];
      return;
    }

    _filteredTutors = _allTutors.where((tutor) {
      final queryLower = _searchQuery.toLowerCase();
      final nombreLower = tutor.nombre.toLowerCase();
      final materiaLower = tutor.materia.toLowerCase();

      return nombreLower.contains(queryLower) ||
          materiaLower.contains(queryLower);
    }).toList();
  }

  void _clearSearch() {
    _searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // --- 1. Barra de Búsqueda Actualizada ---
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4.0,
              vertical: 10.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController, // Conectamos el controlador
                    decoration: InputDecoration(
                      hintText: 'Buscar...',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      suffixIcon: _isSearching
                          ? IconButton(
                              // Botón 'X' para limpiar
                              icon: const Icon(Icons.close),
                              onPressed: _clearSearch,
                            )
                          : const Icon(Icons.search), // Ícono de lupa
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 20.0,
                      ),
                    ),
                  ),
                ),
                // Botón "Cancelar" que aparece al buscar
                if (_isSearching)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextButton(
                      onPressed: _clearSearch,
                      child: const Text('Cancelar'),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // --- 2. Contenido Condicional ---
          Expanded(
            child: _isSearching
                ? _buildSearchResults() // Muestra la lista de tutores si está buscando
                : _buildCategoryGrid(), // Muestra la cuadrícula si no
          ),
        ],
      ),
    );
  }

  // --- Widget para mostrar los resultados de la búsqueda ---
  Widget _buildSearchResults() {
    if (_filteredTutors.isEmpty) {
      return const Center(child: Text('No se encontraron tutores.'));
    }

    // Usamos el mismo widget de tarjeta de tutor de la HomePage
    return ListView.builder(
      itemCount: _filteredTutors.length,
      itemBuilder: (context, index) {
        final tutor = _filteredTutors[index];
        return _buildTutorCard(context, tutor); // Pasamos 'context'
      },
    );
  }

  // --- Widget para la cuadrícula (tu código anterior) ---
  Widget _buildCategoryGrid() {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
      children: [
        _buildCategoryCard(
          title: 'Inglés',
          iconPath: 'assets/images/Ingles.png',
          color: AppColors.color2,
        ),
        _buildCategoryCard(
          title: 'Bioquímica',
          iconPath: 'assets/images/Bioquimica.png',
          color: AppColors.color4,
        ),
        _buildCategoryCard(
          title: 'Programación',
          iconPath: 'assets/images/Programacion.png',
          color: const Color(0xFFC8E6C9),
        ),
        _buildCategoryCard(
          title: 'Mátematicas',
          iconPath: 'assets/images/matematicas.png',
          color: const Color(0xFFFFCDD2),
        ),
        _buildCategoryCard(
          title: 'Canto',
          iconPath: 'assets/images/Canto.png',
          color: AppColors.color3,
        ),
        _buildCategoryCard(
          title: 'Español',
          iconPath: 'assets/images/espanol.png',
          color: const Color(0xFFB2DFDB),
        ),
      ],
    );
  }

  // --- Widget Auxiliar para cada Tarjeta de Categoría ---
  Widget _buildCategoryCard({
    required String title,
    required String iconPath,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: InkWell(
        onTap: () {
          // Ahora, al tocar una categoría, podemos poner su nombre en la búsqueda
          _searchController.text = title;
        },
        borderRadius: BorderRadius.circular(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: 60,
              height: 60,
              color: AppColors.black,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
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
