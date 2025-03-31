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
    if (json['attributes'] != null) {
      final attributes = json['attributes'];
      return Sublocalidade(
        id: json['id'],
        nome: attributes['nome'],
        descricao: attributes['descricao'],
        idLocalidade: attributes['idLocalidade'],
      );
    }
    return Sublocalidade(
      id: int.parse(json['id'].toString()),
      nome: json['nome'],
      descricao: json['descricao'],
      idLocalidade: json['idLocalidade'],
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
