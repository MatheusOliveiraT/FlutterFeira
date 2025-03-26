// ignore_for_file: file_names

class Localidade {
  final int? id;
  final String nome;
  final String descricao;
  final int quantidadeSalas;

  Localidade({
    this.id,
    required this.nome,
    required this.descricao,
    required this.quantidadeSalas,
  });

  @override
  String toString() {
    return 'Localidade {\nid: $id, \nnome: $nome, \nquantidadeSalas: $quantidadeSalas, \ndescricao: $descricao\n}';
  }
}
