class Estudante {
  int? id;
  String nome;
  String matricula;

  Estudante({
    this.id,
    required this.nome,
    required this.matricula,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'matricula': matricula,
    };
  }

  factory Estudante.fromMap(Map<String, dynamic> map) {
    return Estudante(
      id: map['id'] as int?,
      nome: map['nome'] as String,
      matricula: map['matricula'] as String,
    );
  }
}
