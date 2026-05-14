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
  String _equation = "0";
  String _currentInput = "0";
  double num1 = 0;
  double num2 = 0;
  String operand = "";
  bool _evaluated = false;

  final TextEditingController _controller = TextEditingController(text: "0");

  void _buttonPressed(String buttonText) {
    if (buttonText == "Limpiar") {
      _equation = "0";
      _currentInput = "0";
      num1 = 0;
      num2 = 0;
      operand = "";
      _evaluated = false;
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "×" ||
        buttonText == "/") {
      if (_evaluated) {
        _evaluated = false;
      }

      if (_currentInput.isNotEmpty && _currentInput != "Error") {
        if (operand.isNotEmpty) {
          num2 = double.tryParse(_currentInput) ?? 0;
          if (operand == "+") num1 = num1 + num2;
          if (operand == "-") num1 = num1 - num2;
          if (operand == "×") num1 = num1 * num2;
          if (operand == "/") num1 = num2 != 0 ? (num1 / num2) : double.nan;
        } else {
          num1 = double.tryParse(_currentInput) ?? 0;
        }
      } else if (_currentInput.isEmpty && operand.isEmpty) {
        num1 = double.tryParse(_equation) ?? 0;
      }

      operand = buttonText;
      _currentInput = "";

      String n1Str = num1.toString();
      if (n1Str.endsWith(".0")) n1Str = n1Str.replaceAll(".0", "");
      if (num1.isNaN) {
        _equation = "Error";
        operand = "";
        _currentInput = "";
      } else {
        _equation = "$n1Str $operand ";
      }
    } else if (buttonText == "=") {
      if (_currentInput.isNotEmpty && operand.isNotEmpty) {
        num2 = double.tryParse(_currentInput) ?? 0;
        double result = 0;
        if (operand == "+") result = num1 + num2;
        if (operand == "-") result = num1 - num2;
        if (operand == "×") result = num1 * num2;
        if (operand == "/") result = num2 != 0 ? (num1 / num2) : double.nan;

        String resStr = result.toString();
        if (resStr.endsWith(".0")) resStr = resStr.replaceAll(".0", "");

        if (result.isNaN) {
          _equation = "Error";
          _currentInput = "";
        } else {
          _equation = resStr;
          _currentInput = resStr;
        }

        num1 = 0;
        num2 = 0;
        operand = "";
        _evaluated = true;
      }
    } else {
      if (_evaluated || _equation == "0" || _equation == "Error") {
        _currentInput = buttonText;
        _equation = buttonText;
        _evaluated = false;
      } else {
        _currentInput = _currentInput + buttonText;
        if (operand.isNotEmpty) {
          String n1Str = num1.toString();
          if (n1Str.endsWith(".0")) n1Str = n1Str.replaceAll(".0", "");
          _equation = "$n1Str $operand $_currentInput";
        } else {
          _equation = _currentInput;
        }
      }
    }

    setState(() {
      _controller.text = _equation;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold provee la estructura básica de la pantalla (Barra superior y cuerpo)
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'), // Título en la barra superior
      ),
      // SingleChildScrollView permite que se pueda deslizar hacia abajo si el teclado tapa la pantalla
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              readOnly: true,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                labelText: 'Resultado', // Etiqueta descriptiva
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
                    ButtonWidget(
                      content: '9',
                      onPressed: () => _buttonPressed('9'),
                    ),
                    ButtonWidget(
                      content: '8',
                      onPressed: () => _buttonPressed('8'),
                    ),
                    ButtonWidget(
                      content: '7',
                      onPressed: () => _buttonPressed('7'),
                    ),
                    ButtonWidget(
                      content: '/',
                      backgroundColor: Colors.redAccent,
                      onPressed: () => _buttonPressed('/'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWidget(
                      content: '6',
                      onPressed: () => _buttonPressed('6'),
                    ),
                    ButtonWidget(
                      content: '5',
                      onPressed: () => _buttonPressed('5'),
                    ),
                    ButtonWidget(
                      content: '4',
                      onPressed: () => _buttonPressed('4'),
                    ),
                    ButtonWidget(
                      content: '×',
                      backgroundColor: Colors.redAccent,
                      onPressed: () => _buttonPressed('×'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWidget(
                      content: '3',
                      onPressed: () => _buttonPressed('3'),
                    ),
                    ButtonWidget(
                      content: '2',
                      onPressed: () => _buttonPressed('2'),
                    ),
                    ButtonWidget(
                      content: '1',
                      onPressed: () => _buttonPressed('1'),
                    ),
                    ButtonWidget(
                      content: '+',
                      backgroundColor: Colors.redAccent,
                      onPressed: () => _buttonPressed('+'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWidget(
                      content: 'Limpiar',
                      onPressed: () => _buttonPressed('Limpiar'),
                    ),
                    ButtonWidget(
                      content: '0',
                      onPressed: () => _buttonPressed('0'),
                    ),
                    ButtonWidget(
                      content: '=',
                      onPressed: () => _buttonPressed('='),
                    ),
                    ButtonWidget(
                      content: '-',
                      backgroundColor: Colors.redAccent,
                      onPressed: () => _buttonPressed('-'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
