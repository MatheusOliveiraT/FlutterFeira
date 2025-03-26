class Departamento {
  final int? id;
  final String nome;

  Departamento({this.id, required this.nome});

  @override
  String toString() {
    return 'Atividade{\nid: $id, \nnome: $nome\n}';
  }
}
