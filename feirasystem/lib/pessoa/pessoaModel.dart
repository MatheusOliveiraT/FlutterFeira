// ignore_for_file: file_names

abstract class Pessoa {
  final int id;
  final String nome;
  final String email;
  final String celular;

  Pessoa(
    this.id,
    this.nome,
    this.email,
    this.celular,
  );

  @override
  String toString() {
    return 'Pessoa {\nid: $id, \nnome: $nome, \nquantidadeSalas: $celular\n}';
  }
}

class Monitor extends Pessoa {
  final String ra;

  Monitor(super.id, super.nome, super.email, super.celular, this.ra);

  @override
  String toString() {
    return 'Monitor {\nid: $id, \nnome: $nome, \nquantidadeSalas: $celular, \nra: $ra\n}';
  }
}

class Organizador extends Pessoa {
  Organizador(super.id, super.nome, super.email, super.celular);

  @override
  String toString() {
    return 'Organizador {\nid: $id, \nnome: $nome, \nquantidadeSalas: $celular\n}';
  }
}
