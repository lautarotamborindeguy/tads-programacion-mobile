import 'package:flutter/material.dart';

// Función principal que inicia la aplicación
void main() {
  runApp(const MiAppDeViaje());
}

// Widget principal de la aplicación (Stateless porque no cambia de estado globalmente)
class MiAppDeViaje extends StatelessWidget {
  const MiAppDeViaje({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora de Viaje',
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
  // Controladores para leer el texto que el usuario ingresa en los campos
  final TextEditingController _distanciaController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _consumoController = TextEditingController();
  final TextEditingController _velocidadController = TextEditingController();

  // Variables para guardar los resultados y mostrarlos luego en la pantalla
  String _resultadoCosto = "";
  String _resultadoTiempo = "";

  // Variables para saber si el resultado es un error (para pintarlo de rojo)
  bool _esErrorCosto = false;
  bool _esErrorTiempo = false;

  // Función para calcular el costo del viaje
  void _calcularCosto() {
    // Convertimos los numeros (string) ingresado a números decimales (double)
    // Si el usuario deja el campo vacío o ingresa letras, usamos 0.0 por defecto
    double distancia = double.tryParse(_distanciaController.text) ?? 0.0;
    double precio = double.tryParse(_precioController.text) ?? 0.0;
    double consumo = double.tryParse(_consumoController.text) ?? 0.0;

    if (distancia > 0 && precio > 0 && consumo > 0) {
      // Fórmula del enunciado
      double costo = (distancia / consumo) * precio;

      // setState le avisa a Flutter que actualice la pantalla con los nuevos valores
      setState(() {
        // .toStringAsFixed(2) sirve para mostrar solo 2 decimales
        _resultadoCosto = "Costo estimado: R\$ ${costo.toStringAsFixed(2)}";
        _esErrorCosto = false; // No es un error
      });
    } else {
      // Si hay datos incorrectos o vacíos, mostramos un mensaje de error
      setState(() {
        _resultadoCosto = "Por favor, ingrese valores válidos mayores a 0.";
        _esErrorCosto =
            true; // Acá cambia a error, lo utilizo para pintar a rojo el texto (UX)
      });
    }
  }

  // Función para calcular el tiempo del viaje
  void _calcularTiempo() {
    double distancia = double.tryParse(_distanciaController.text) ?? 0.0;
    double velocidad = double.tryParse(_velocidadController.text) ?? 0.0;

    if (distancia > 0 && velocidad > 0) {
      // Fórmula del enunciado
      double tiempo = distancia / velocidad;

      setState(() {
        _resultadoTiempo = "Tiempo estimado: ${tiempo.toStringAsFixed(2)} h";
        _esErrorTiempo = false; // No es un error
      });
    } else {
      // Mensaje de error si la velocidad o distancia son incorrectas
      setState(() {
        _resultadoTiempo =
            "Por favor, ingrese distancia y velocidad mayores a 0.";
        _esErrorTiempo = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold provee la estructura básica de la pantalla (Barra superior y cuerpo)
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculadora de Viaje',
        ), // Título en la barra superior
      ),
      // SingleChildScrollView permite que se pueda deslizar hacia abajo si el teclado tapa la pantalla
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Campo de texto 1: Distancia
            TextField(
              controller: _distanciaController, // Conectamos su controlador
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ), // Activa teclado numérico
              decoration: const InputDecoration(
                labelText: 'Distancia (km)', // Etiqueta descriptiva
                border:
                    OutlineInputBorder(), // Le da un borde atractivo al campo
              ),
            ),
            const SizedBox(
              height: 16,
            ), // Espacio en blanco para separar elementos
            // Campo de texto 2: Precio del combustible
            TextField(
              controller: _precioController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Precio del combustible (R\$/L)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Campo de texto 3: Consumo del vehículo
            TextField(
              controller: _consumoController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Consumo del vehículo (km/L)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Campo de texto 4: Velocidad media
            TextField(
              controller: _velocidadController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Velocidad media (km/h)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            // Primer botón: Calcular Costo
            ElevatedButton(
              onPressed:
                  _calcularCosto, // Cuando se aprieta, ejecuta _calcularCosto
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ), // Hace el botón más alto
                backgroundColor: Colors.green, // Color de fondo del botón
                foregroundColor: Colors.white, // Color del texto del botón
              ),
              child: const Text(
                'Calcular Costo',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 12),

            // Texto debajo del botón 1 para mostrar el resultado del costo
            Text(
              _resultadoCosto,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _esErrorCosto
                    ? Colors.red
                    : Colors.green, // Rojo si es error
              ),
              textAlign: TextAlign.center, // Lo centra en la pantalla
            ),
            const SizedBox(height: 24),

            // Segundo botón: Calcular Tiempo
            ElevatedButton(
              onPressed: _calcularTiempo,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Calcular Tiempo',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 12),

            Text(
              _resultadoTiempo,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _esErrorTiempo ? Colors.red : Colors.blueAccent,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
