import 'package:flutter/material.dart';
import 'package:nuttu_project/core/services/auth_services.dart';
// Importamos nuestros temas de colores y degradados
import 'package:nuttu_project/app/theme/app_colors.dart';
import 'package:nuttu_project/app/theme/app_gradiants.dart';
import 'package:nuttu_project/features/home/presentation/pages/main_page.dart'; // <-- Importa MainPage

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();

  // Función para manejar el login
  void _login() async {
    // Aquí puedes añadir validaciones básicas antes de enviar
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingresa email y contraseña.')),
      );
      return;
    }

    final success = await _authService.login(
      _emailController.text,
      _passwordController.text,
    );

    if (mounted) {
      if (success) {
        // Si el login es exitoso, navegamos a la HomePage
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error: Credenciales inválidas.')),
        );
      }
    }
  }

  // Función para manejar el registro
  void _register() async {
    // Aquí puedes añadir validaciones básicas antes de enviar
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Por favor, ingresa email y contraseña para registrarte.',
          ),
        ),
      );
      return;
    }

    final success = await _authService.register(
      _emailController.text,
      _passwordController.text,
    );

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('¡Registro exitoso! Por favor, inicia sesión.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error: El email ya está en uso o hubo un problema.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // El Scaffold es el lienzo principal de la pantalla.
    return Scaffold(
      // Usamos un Container como fondo para aplicar el degradado
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradiants.primaryGradiant, // Nuestro degradado principal
        ),
        child: Center(
          child: SingleChildScrollView(
            // Permite hacer scroll si el teclado aparece
            padding: const EdgeInsets.all(20.0),
            child: Card(
              // Usamos Card para la forma redondeada y la elevación
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  20.0,
                ), // Bordes redondeados de la tarjeta
              ),
              color: AppColors.colorDark.withAlpha(
                204,
              ), // Color de fondo de la tarjeta con opacidad
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 40.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize
                      .min, // Para que la columna ocupe el espacio mínimo necesario
                  children: [
                    // Texto "LOGIN"
                    const Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white, // Color de texto blanco
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Icono de perfil (Puedes reemplazar esto con tu propia imagen de perfil si tienes una)
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.color2, // Fondo del círculo
                      child: Icon(
                        Icons.person,
                        size: 70,
                        color: AppColors.colorDark, // Color del icono
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Campo de usuario (Email)
                    const Text(
                      'USUARIO',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        color: AppColors.colorDark,
                      ), // Color del texto que se escribe
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.white, // Fondo del campo de texto
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none, // Sin borde visible
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Campo de contraseña
                    const Text(
                      'CONTRASEÑA',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      style: const TextStyle(color: AppColors.colorDark),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Botón "ENTRAR" con degradado
                    Container(
                      width: double.infinity, // Ancho completo
                      decoration: BoxDecoration(
                        gradient: AppGradiants
                            .secondaryGradiant, // Nuestro degradado para el botón
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .transparent, // Fondo transparente para mostrar el degradado
                          shadowColor:
                              Colors.transparent, // Sin sombra del botón
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text(
                          'ENTRAR',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Iconos de redes sociales
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Botón de Google (Gmail)
                        _buildSocialButton(
                          'assets/images/gmail_icon.png',
                          Colors.white,
                        ),
                        // Botón de Facebook
                        _buildSocialButton(
                          'assets/images/facebook_icon.png',
                          AppColors.facebookBlue,
                        ),
                        // Botón de Apple
                        _buildSocialButton(
                          'assets/images/apple_icon.png',
                          Colors.black,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Texto "¿Eres Nuevo? Registrar"
                    GestureDetector(
                      // Para detectar taps en el texto
                      onTap: () {
                        // Aquí podrías navegar a una página de registro separada
                        // o abrir un diálogo para el registro rápido.
                        // Por ahora, simplemente llamaremos a la función _register
                        // con los datos ingresados en los campos.
                        _register();
                      },
                      child: Text.rich(
                        TextSpan(
                          text: '¿Eres Nuevo? ',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.white.withAlpha(204),
                          ),
                          children: const [
                            TextSpan(
                              text: 'Registrar',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors
                                    .color3, // Usamos tu color accent para resaltar
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget auxiliar para construir los botones de redes sociales
  // Ahora acepta un color de fondo
  Widget _buildSocialButton(String assetPath, Color backgroundColor) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: backgroundColor, // <-- Aquí aplicamos el color recibido
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(
              51,
            ), // Usamos .withAlpha() como corregimos
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Image.asset(
          assetPath,
          width: 35, // Tamaño del icono dentro del círculo
          height: 35,
        ),
      ),
    );
  }
}
