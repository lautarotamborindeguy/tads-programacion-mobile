import 'package:bd/databasehelper.dart';
import 'package:bd/estudiante.dart';

class estudianteDAO {
  final Databasehelper _databasehelper = Databasehelper();
  
  Future <void> addEstudiante(estudiante e) async {
    final db = await _databasehelper.database;
    await db.insert('estudiantes', e.toMap());
  }

  Future <void> updateEstudiante(estudiante e) async {
    final db = await _databasehelper.database;
    await db.update('estudiantes', e.toMap(), where: 'id = ?', whereArgs: [e.id]);
  }

  Future <void> deleteEstudiante(estudiante e) async {
    final db = await _databasehelper.database;
    await db.delete('estudiantes', where: 'id = ?', whereArgs: [e.id]);
  }

  Future <List<estudiante>> getEstudiante() async {
    final db = await _databasehelper.database;
    final List<Map<String, dynamic>> maps = await db.query('estudiantes');
    return List.generate(maps.length, (i) {
      return estudiante.fromMap(maps[i]);
    });
  }
}