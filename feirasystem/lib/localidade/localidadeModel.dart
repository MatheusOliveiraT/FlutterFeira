class Localidade {
  final int? id;
  final String nome;
  final int quantidadeSalas;
  final String descricao;

  Localidade({
    this.id,
    required this.nome,
    required this.quantidadeSalas,
    required this.descricao,
  });

  @override
  String toString() {
    return 'Localidade {\nid: $id, \nnome: $nome, \nquantidadeSalas: $quantidadeSalas, \ndescricao: $descricao\n}';
  }

  factory Localidade.fromJson(Map<String, dynamic> json) {
    if (json['attributes'] != null) {
      final attributes = json['attributes'];
      return Localidade(
        id: json['id'],
        nome: attributes['nome'],
        quantidadeSalas: attributes['quantidadeSalas'],
        descricao: attributes['descricao'],
      );
    }
    return Localidade(
      id: int.parse(json['id'].toString()),
      nome: json['nome'],
      quantidadeSalas: json['quantidadeSalas'],
      descricao: json['descricao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'quantidadeSalas': quantidadeSalas,
      'descricao': descricao,
    };
  }
}
