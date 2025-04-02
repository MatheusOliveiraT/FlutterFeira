class Departamento {
  final int? id;
  final String nome;

  Departamento({this.id, required this.nome});

  @override
  String toString() {
    return 'Departamento {\n id: $id, \n nome: $nome\n}';
  }

  factory Departamento.fromJson(Map<String, dynamic> json) {
    if (json['attributes'] != null) {
      final attributes = json['attributes'];
      return Departamento(
        id: json['id'],
        nome: attributes['nome'],
      );
    }
    return Departamento(
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
