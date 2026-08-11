import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Calculadora',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Mini Calculadora'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController(text: '0');
  double _value = 0.0;

  double _parseInputValue() {
    final text = _controller.text.trim().replaceAll(',', '.');
    return double.tryParse(text) ?? _value;
  }

  void _setValue(double newValue) {
    setState(() {
      _value = newValue;
      _controller.text = _value.toString();
    });
  }

  void _applyOperation(String operation) {
    final current = _parseInputValue();
    double result = current;

    switch (operation) {
      case 'add':
        result = current + 1;
        break;
      case 'subtract':
        result = current - 1;
        break;
      case 'multiply':
        result = current * 2;
        break;
      case 'divide':
        result = current / 2;
        break;
      default:
        break;
    }

    _setValue(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Valor actual',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              _value.toString(),
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Ingrese un valor',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) {
                final parsed = _parseInputValue();
                _setValue(parsed);
              },
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                _buildActionButton('Restar 1', Colors.red, () => _applyOperation('subtract')),
                _buildActionButton('Sumar 1', Colors.green, () => _applyOperation('add')),
                _buildActionButton('Multiplicar x2', Colors.blue, () => _applyOperation('multiply')),
                _buildActionButton('Dividir /2', Colors.orange, () => _applyOperation('divide')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: 160,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
