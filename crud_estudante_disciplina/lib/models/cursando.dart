class Cursando {
  int? id;
  int estudanteId;
  int disciplinaId;

  Cursando({
    this.id,
    required this.estudanteId,
    required this.disciplinaId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'estudante_id': estudanteId,
      'disciplina_id': disciplinaId,
    };
  }

  factory Cursando.fromMap(Map<String, dynamic> map) {
    return Cursando(
      id: map['id'] as int?,
      estudanteId: map['estudante_id'] as int,
      disciplinaId: map['disciplina_id'] as int,
    );
  }
}

class CursandoJoin {
  final int id;
  final int estudanteId;
  final int disciplinaId;
  final String estudanteNome;
  final String estudanteMatricula;
  final String disciplinaNome;
  final String professor;

  CursandoJoin({
    required this.id,
    required this.estudanteId,
    required this.disciplinaId,
    required this.estudanteNome,
    required this.estudanteMatricula,
    required this.disciplinaNome,
    required this.professor,
  });

  factory CursandoJoin.fromMap(Map<String, dynamic> map) {
    return CursandoJoin(
      id: map['id'] as int,
      estudanteId: map['estudante_id'] as int,
      disciplinaId: map['disciplina_id'] as int,
      estudanteNome: map['estudante_nome'] as String,
      estudanteMatricula: map['estudante_matricula'] as String,
      disciplinaNome: map['disciplina_nome'] as String,
      professor: map['professor'] as String,
    );
  }
}
