import 'package:flutter/material.dart';
import 'package:first_app/widgets/app_text_field.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key, required this.username});

  final String username;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _courseController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  void _saveData() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Datos guardados'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nombre: ${_nameController.text}'),
              Text('Dirección: ${_addressController.text}'),
              Text('Curso: ${_courseController.text}'),
              Text('Ciudad: ${_cityController.text}'),
              Text('País: ${_countryController.text}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Bienvenido ${widget.username}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 20),
            AppTextField(
              controller: _nameController,
              label: 'Nombre',
            ),
            const SizedBox(height: 12),
            AppTextField(
              controller: _addressController,
              label: 'Dirección',
            ),
            const SizedBox(height: 12),
            AppTextField(
              controller: _courseController,
              label: 'Curso',
            ),
            const SizedBox(height: 12),
            AppTextField(
              controller: _cityController,
              label: 'Ciudad',
            ),
            const SizedBox(height: 12),
            AppTextField(
              controller: _countryController,
              label: 'País',
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _saveData,
                      child: const Text('Guardar'),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Volver al inicio de sesión'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
