import 'package:flutter/material.dart';
import 'package:calculadora/widgets/button.dart';

// Función principal que inicia la aplicación
void main() {
  runApp(const Calculadora());
}

// Widget principal de la aplicación (Stateless porque no cambia de estado globalmente)
class Calculadora extends StatelessWidget {
  const Calculadora({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const PantallaCalculadora(), // Define la pantalla inicial a mostrar
    );
  }
}

// Pantalla principal donde ocurre la lógica (Stateful porque los datos en pantalla cambian)
class PantallaCalculadora extends StatefulWidget {
  const PantallaCalculadora({super.key});

  @override
  State<PantallaCalculadora> createState() => _PantallaCalculadoraState();
}

class _PantallaCalculadoraState extends State<PantallaCalculadora> {
  @override
  Widget build(BuildContext context) {
    // Scaffold provee la estructura básica de la pantalla (Barra superior y cuerpo)
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculadora',
        ), // Título en la barra superior
      ),
      // SingleChildScrollView permite que se pueda deslizar hacia abajo si el teclado tapa la pantalla
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Calculadora', // Etiqueta descriptiva
                border:
                    OutlineInputBorder(), // Le da un borde atractivo al campo
              ),
            ),
            const SizedBox(
              height: 16,
            ), // Espacio en blanco para separar elementos
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWidget(content: '9'),
                    ButtonWidget(content: '8'),
                    ButtonWidget(content: '7'),
                    ButtonWidget(content: '/', backgroundColor: Colors.redAccent)
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWidget(content: '6'),
                    ButtonWidget(content: '5'),
                    ButtonWidget(content: '4'),
                    ButtonWidget(content: '×', backgroundColor: Colors.redAccent)
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWidget(content: '3'),
                    ButtonWidget(content: '2'),
                    ButtonWidget(content: '1'),
                    ButtonWidget(content: '+', backgroundColor: Colors.redAccent)
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWidget(content: 'Limpiar'),
                    ButtonWidget(content: '0'),
                    ButtonWidget(content: '='),
                    ButtonWidget(content: '-', backgroundColor: Colors.redAccent)
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
