
import 'package:feirasystem/atividade/atividadeModel.dart';

class MockBuilder {
  static retrieveAtividades(){
    List<Atividade> atividades = [
    retrieveAtividadeSublocalidade(),
    retrieveAtividadeLocalidade()
    ];
    return atividades;
  }
  static retrieveAtividadeSublocalidade(){
    Atividade atividade = Atividade(
      id: 1,
      nome: "Atividade de Teste",
      descricao: "Descrição da atividade de teste",
      duracaoSecao: 60,
      quantidadeMonitores: 2,
      idFeira: 1,
      idProfessor: 1, 
      tipoAtividade: TipoAtividade.SUBLOCALIDADE,
      status: Status.OCUPADA,
      idLocalidade: 1,
      idSublocalidade: 1,
    );
    return atividade;

  }


  static retrieveAtividadeLocalidade(){
    Atividade atividade = Atividade(
      id: 2,
      nome: "Atividade de Teste Localidade",
      descricao: "Descrição da atividade de teste para localidade",
      duracaoSecao: 45,
      quantidadeMonitores: 3,
      idFeira: 1,
      idProfessor: 2, 
      tipoAtividade: TipoAtividade.LOCALIDADE,
      status: Status.OCIOSA,
      idLocalidade: 2,
    );
    return atividade;

  }

}