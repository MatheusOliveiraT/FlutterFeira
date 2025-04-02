class Professor {
  final int? id;
  final String nome;
  final int idDepartamento;

  Professor({this.id, required this.nome, required this.idDepartamento});

  @override
  String toString() {
    return 'Professor {\n id: $id, \n nome: $nome, \n idDepartamento: $idDepartamento\n}';
  }

  factory Professor.fromJson(Map<String, dynamic> json) {
    if (json['attributes'] != null) {
      final attributes = json['attributes'];
      return Professor(
        id: json['id'],
        nome: attributes['nome'],
        idDepartamento: attributes['idDepartamento'],
      );
    }
    return Professor(
      id: int.parse(json['id'].toString()),
      nome: json['nome'],
      idDepartamento: int.parse(json['idDepartamento']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'idDepartamento': idDepartamento,
    };
  }
}
