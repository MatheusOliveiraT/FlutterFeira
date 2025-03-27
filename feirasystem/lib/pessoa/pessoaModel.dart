abstract class Pessoa {
  final int id;
  final String nome;
  final String celular;
  final String email;

  Pessoa(
    this.id,
    this.nome,
    this.celular,
    this.email
  );

  @override
  String toString(){
    return "Nome: $nome, Celular: $celular, Email: $email";
  }
}
