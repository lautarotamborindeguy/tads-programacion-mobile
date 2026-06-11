import 'package:crud_estudante_disciplina/database_helper.dart';
import 'package:crud_estudante_disciplina/models/cursando.dart';

class CursandoDao {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> addCursando(Cursando cursando) async {
    final db = await _databaseHelper.database;
    return db.insert('cursando', cursando.toMap());
  }

  Future<int> updateCursando(Cursando cursando) async {
    final db = await _databaseHelper.database;
    return db.update(
      'cursando',
      cursando.toMap(),
      where: 'id = ?',
      whereArgs: [cursando.id],
    );
  }

  Future<int> deleteCursando(Cursando cursando) async {
    final db = await _databaseHelper.database;
    return db.delete(
      'cursando',
      where: 'id = ?',
      whereArgs: [cursando.id],
    );
  }

  Future<List<CursandoJoin>> getCursandoComJoin() async {
    final db = await _databaseHelper.database;
    final maps = await db.rawQuery('''
      SELECT
        c.id,
        c.estudante_id,
        c.disciplina_id,
        e.nome AS estudante_nome,
        e.matricula AS estudante_matricula,
        d.nome AS disciplina_nome,
        d.professor AS professor
      FROM cursando c
      INNER JOIN estudantes e ON e.id = c.estudante_id
      INNER JOIN disciplinas d ON d.id = c.disciplina_id
      ORDER BY e.nome, d.nome
    ''');
    return maps.map(CursandoJoin.fromMap).toList();
  }
}
