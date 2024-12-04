// ignore_for_file: file_names

class Localidade {
  final String nome;
  final int quantidadeSalas;

  Localidade(
    this.nome,
    this.quantidadeSalas,
  );

  @override
  String toString() {
    return 'Localidade{nome: $nome, quantidadeSalas: $quantidadeSalas';
  }
}