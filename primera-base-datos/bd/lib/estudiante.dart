class estudiante {
  int? id;
  String? nombre;
  String? matricula;
  estudiante({this.id, required this.nombre, required this.matricula});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'matricula': matricula,
    };
  }
  factory estudiante.fromMap(Map<String, dynamic> map) {
    return estudiante(
      id: map['id'],
      nombre: map['nombre'],
      matricula: map['matricula'],
    );
  }
}