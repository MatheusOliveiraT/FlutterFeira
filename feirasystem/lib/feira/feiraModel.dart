class Feira {
  final int? id;
  final String nome;

  Feira({this.id, required this.nome});

  @override
  String toString() {
    return 'Feira {\nid: $id, \nnome: $nome\n}';
  }

  factory Feira.fromJson(Map<String, dynamic> json) {
    if (json['attributes'] != null) {
      final attributes = json['attributes'];
      return Feira(
        id: json['id'],
        nome: attributes['nome'],
      );
    }
    return Feira(
      id: int.parse(json['id'].toString()),
      nome: json['nome'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
    };
  }
}
