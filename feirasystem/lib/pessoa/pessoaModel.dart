// ignore_for_file: file_names

abstract class Pessoa {
  final int? id;
  final String nome;
  final String email;
  final String celular;

  Pessoa({
    this.id,
    required this.nome,
    required this.email,
    required this.celular,
  });

  @override
  String toString() {
    return 'Pessoa {\nid: $id, \nnome: $nome, \nemail: $email, \ncelular: $celular\n}';
  }
}

class Monitor extends Pessoa {
  final String ra;

  Monitor(
      {super.id,
      required super.nome,
      required super.email,
      required super.celular,
      required this.ra});

  @override
  String toString() {
    return 'Monitor {\nid: $id, \nnome: $nome, \nemail: $email, \ncelular: $celular, \nra: $ra\n}';
  }
}

class Organizador extends Pessoa {
  Organizador(
      {super.id,
      required super.nome,
      required super.email,
      required super.celular});

  @override
  String toString() {
    return 'Organizador {\nid: $id, \nnome: $nome, \nemail: $email, \ncelular: $celular\n}';
  }
}
