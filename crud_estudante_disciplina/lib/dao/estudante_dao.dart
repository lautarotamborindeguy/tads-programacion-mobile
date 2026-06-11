import 'package:crud_estudante_disciplina/database_helper.dart';
import 'package:crud_estudante_disciplina/models/estudante.dart';

class EstudanteDao {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> addEstudante(Estudante estudante) async {
    final db = await _databaseHelper.database;
    return db.insert('estudantes', estudante.toMap());
  }

  Future<int> updateEstudante(Estudante estudante) async {
    final db = await _databaseHelper.database;
    return db.update(
      'estudantes',
      estudante.toMap(),
      where: 'id = ?',
      whereArgs: [estudante.id],
    );
  }

  Future<int> deleteEstudante(Estudante estudante) async {
    final db = await _databaseHelper.database;
    return db.delete(
      'estudantes',
      where: 'id = ?',
      whereArgs: [estudante.id],
    );
  }

  Future<List<Estudante>> getEstudantes() async {
    final db = await _databaseHelper.database;
    final maps = await db.query('estudantes', orderBy: 'nome');
    return maps.map(Estudante.fromMap).toList();
  }
}
