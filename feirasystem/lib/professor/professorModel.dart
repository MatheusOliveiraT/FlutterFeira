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
    return Professor(
      id: int.parse(json['id'].toString()),
      nome: json['nome'],
      idDepartamento: int.parse(json['idDepartamento'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'idDepartamento': idDepartamento,
    };
  }
}
