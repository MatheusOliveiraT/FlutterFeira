import 'package:feirasystem/pessoa/pessoaModel.dart';


class Monitor extends Pessoa{
  final String ra;

  // ignore: use_super_parameters
  Monitor(int id, String nome, String celular, String email, this.ra): super(id, nome, celular, email);

  @override
  String toString(){
    return "RA: $ra, Nome: $nome, Celular: $celular, Email: $email";
  }
}
