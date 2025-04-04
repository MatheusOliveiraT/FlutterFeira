class Sublocalidade {
  final int? id;
  final String nome;
  final String descricao;
  final int idLocalidade;

  Sublocalidade({
    this.id,
    required this.nome,
    required this.descricao,
    required this.idLocalidade,
  });

  @override
  String toString() {
    return 'Sublocalidade{\nnome: $nome, \ndescrição: $descricao, \nidLocalidade: $idLocalidade\n}';
  }

  factory Sublocalidade.fromJson(Map<String, dynamic> json) {
    return Sublocalidade(
      id: int.parse(json['id'].toString()),
      nome: json['nome'],
      descricao: json['descricao'],
      idLocalidade: int.parse(json['idLocalidade'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'descricao': descricao,
      'idLocalidade': idLocalidade,
    };
  }
}
