class Disciplina {
  int? id;
  String nome;
  String professor;

  Disciplina({
    this.id,
    required this.nome,
    required this.professor,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'professor': professor,
    };
  }

  factory Disciplina.fromMap(Map<String, dynamic> map) {
    return Disciplina(
      id: map['id'] as int?,
      nome: map['nome'] as String,
      professor: map['professor'] as String,
    );
  }
}
