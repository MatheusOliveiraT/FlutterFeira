
import 'package:feirasystem/agendamentoFeira/agendamentoFeiraModel.dart';
import 'package:feirasystem/atividade/atividadeModel.dart';
import 'package:feirasystem/feira/feiraModel.dart';

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

  static retrieveFeiras(){
    final List<Feira> feiras = [
      Feira(id:1, nome:"Feira 1"), 
      Feira(id:2, nome:"Feira 2")];
    return feiras;
  }

  static retrieveAgendamentosFeira(){
    final List<AgendamentoFeira> agendamentos = [
      AgendamentoFeira(id: 1, idFeira: 1, data:DateTime.now(), turno: Turno.MANHA),
      AgendamentoFeira(id: 2, idFeira: 1, data:DateTime.now(), turno: Turno.TARDE),
      AgendamentoFeira(id: 3, idFeira: 1, data:DateTime.now(), turno: Turno.NOITE),
      AgendamentoFeira(id: 4, idFeira: 2, data:DateTime.now(), turno: Turno.MANHA),
      AgendamentoFeira(id: 5, idFeira: 2, data:DateTime.now(), turno: Turno.TARDE),];
    return agendamentos;
  }

}