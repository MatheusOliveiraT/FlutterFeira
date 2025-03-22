class Sublocalidade {
  final int? id;
  final String nome;
  final String descricao;
  final int idLocalidade;

  Sublocalidade(
    this.id,
    this.nome,
    this.descricao,
    this.idLocalidade,
  );

  @override
  String toString() {
    return 'Sublocalidade{\nnome: $nome, \ndescrição: $descricao, \nlocalidade: $idLocalidade\n}';
  }
}
