import 'package:flutter/material.dart';
import 'estudiante.dart';
import 'estudianteDAO.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DatabaseScreen(),
    );
  }
}

class DatabaseScreen extends StatefulWidget {
  const DatabaseScreen({super.key});

  @override
  State<DatabaseScreen> createState() => _DatabaseScreenState();
}

class _DatabaseScreenState extends State<DatabaseScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _matriculaController = TextEditingController();
  final estudianteDAO _dao = estudianteDAO();

  List<estudiante> _estudiantes = [];
  estudiante? _estudianteActual;

  @override
  void initState() {
    super.initState();
    _cargarEstudiantes();
  }

  // Carga la lista de estudiantes desde la base de datos
  // y actualiza el estado de la interfaz para mostrarlos.
  Future<void> _cargarEstudiantes() async {
    final estudiantes = await _dao.getEstudiante();
    setState(() {
      _estudiantes = estudiantes;
    });
  }

  // Guarda un nuevo estudiante o actualiza uno existente.
  Future<void> _guardar() async {
    // Validación: no hacer nada si los campos están vacíos
    if (_nombreController.text.isEmpty || _matriculaController.text.isEmpty)
      return;

    if (_estudianteActual == null) {
      // Si no hay un estudiante seleccionado, se crea uno nuevo y se guarda en la base de datos
      final nuevoEstudiante = estudiante(
        nombre: _nombreController.text,
        matricula: _matriculaController.text,
      );
      await _dao.addEstudiante(nuevoEstudiante);
    } else {
      // Si ya hay un estudiante seleccionado (se apretó el botón de editar), se actualizan sus datos
      _estudianteActual!.nombre = _nombreController.text;
      _estudianteActual!.matricula = _matriculaController.text;
      await _dao.updateEstudiante(_estudianteActual!);
      // Se limpia la selección actual después de actualizar
      _estudianteActual = null;
    }

    // Limpia los campos de texto y recarga la lista de estudiantes
    _nombreController.clear();
    _matriculaController.clear();
    _cargarEstudiantes();
  }

  // Carga los datos del estudiante seleccionado en los campos de texto para poder editarlos.
  void _editar(estudiante e) {
    setState(() {
      _estudianteActual = e; // Guardamos el estudiante que se está editando
      _nombreController.text = e.nombre ?? '';
      _matriculaController.text = e.matricula ?? '';
    });
  }

  // Elimina un estudiante de la base de datos y actualiza la lista.
  Future<void> _eliminar(estudiante e) async {
    await _dao.deleteEstudiante(e);
    _cargarEstudiantes(); // Refresca la lista visual
    
    // Si se elimina el estudiante que se estaba editando actualmente, se limpian los campos y la selección
    if (_estudianteActual?.id == e.id) {
      setState(() {
        _estudianteActual = null;
        _nombreController.clear();
        _matriculaController.clear();
      });
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _matriculaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Interfaz de Base de Datos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _matriculaController,
              decoration: const InputDecoration(
                labelText: 'Matrícula',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _guardar,
              child: Text(_estudianteActual == null ? 'Guardar' : 'Actualizar'),
            ),
            const SizedBox(height: 20),
            const Divider(),
            Expanded(
              child: _estudiantes.isEmpty
                  ? const Center(child: Text('No hay estudiantes registrados'))
                  : ListView.builder(
                      itemCount: _estudiantes.length,
                      itemBuilder: (context, index) {
                        final e = _estudiantes[index];
                        return ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text(e.nombre ?? ''),
                          subtitle: Text('Matrícula: ${e.matricula ?? ''}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () => _editar(e),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => _eliminar(e),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
