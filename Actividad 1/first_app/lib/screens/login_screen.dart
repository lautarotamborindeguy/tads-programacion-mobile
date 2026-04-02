import 'package:first_app/screens/welcome_screen.dart';
import 'package:first_app/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static const String _staticUsername = 'professor';
  static const String _staticPassword = '123456';

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitLogin() {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El usuario y la contraseña son obligatorios.'),
        ),
      );
      return;
    }

    if (username == _staticUsername && password == _staticPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => WelcomeScreen(username: username),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuario o contraseña incorrectos.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla de inicio de sesión'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 52,
                  backgroundImage: NetworkImage(
                    'https://picsum.photos/200',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            AppTextField(
              controller: _usernameController,
              label: 'Nombre de usuario',
              icon: Icons.person,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _passwordController,
              label: 'Contraseña',
              icon: Icons.lock,
              isPassword: true,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: _submitLogin,
                child: const Text('Ingresar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
