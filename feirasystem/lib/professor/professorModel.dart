class Professor {
  final int? id;
  final String nome;
  final int idDepartamento;

  Professor({this.id, required this.nome, required this.idDepartamento});

  @override
  String toString() {
    return 'Atividade{\nid: $id, \nnome: $nome, \nidDepartamento: $idDepartamento\n}';
  }
}
