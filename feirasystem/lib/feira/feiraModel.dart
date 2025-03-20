class Feira {
  final int? id;
  final String? documentId;
  final String nome;

  Feira({this.id, this.documentId, required this.nome});

  @override
  String toString() {
    return 'Feira {\nid: $id, \nnome: $nome\n}';
  }

  factory Feira.fromJson(Map<String, dynamic> json) {
    if (json['attributes'] != null) {
      final attributes = json['attributes'];
      return Feira(
        id: json['id'],
        documentId: attributes['documentId'],
        nome: attributes['nome'],
      );
    }
    return Feira(
      id: int.parse(json['id'].toString()),
      documentId: json['documentId'],
      nome: json['nome'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
    };
  }
}
