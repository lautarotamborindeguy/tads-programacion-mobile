import 'package:crud_estudante_disciplina/database_helper.dart';
import 'package:crud_estudante_disciplina/models/disciplina.dart';

class DisciplinaDao {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> addDisciplina(Disciplina disciplina) async {
    final db = await _databaseHelper.database;
    return db.insert('disciplinas', disciplina.toMap());
  }

  Future<int> updateDisciplina(Disciplina disciplina) async {
    final db = await _databaseHelper.database;
    return db.update(
      'disciplinas',
      disciplina.toMap(),
      where: 'id = ?',
      whereArgs: [disciplina.id],
    );
  }

  Future<int> deleteDisciplina(Disciplina disciplina) async {
    final db = await _databaseHelper.database;
    return db.delete(
      'disciplinas',
      where: 'id = ?',
      whereArgs: [disciplina.id],
    );
  }

  Future<List<Disciplina>> getDisciplinas() async {
    final db = await _databaseHelper.database;
    final maps = await db.query('disciplinas', orderBy: 'nome');
    return maps.map(Disciplina.fromMap).toList();
  }
}
