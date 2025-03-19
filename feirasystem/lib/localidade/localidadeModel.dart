// ignore_for_file: file_names

class Localidade {
  final int id;
  final String nome;
  final int quantidadeSalas;
  final String descricao;

  Localidade(
    this.id,
    this.nome,
    this.quantidadeSalas,
    this.descricao,
  );

  @override
  String toString() {
    return 'Localidade {\nid: $id, \nnome: $nome, \nquantidadeSalas: $quantidadeSalas, \ndescricao: $descricao\n}';
  }
}
