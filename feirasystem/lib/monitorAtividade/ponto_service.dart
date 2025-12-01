
import 'monitorAtividadeModel.dart'; 
import 'ponto_atividade_dto.dart'; 


// 'DateTime' e 'Future' (do Dart)
import 'dart:async'; 

class PontoService {
  final Map<int, bool> _checkInStatus = {};

  bool isMonitorCheckedIn(int idAgendamento) {
    return _checkInStatus[idAgendamento] ?? false;
  }

 
  Future<PontoAtividadeDto> registrarPonto({
    required MonitorAtividade atividade,
  }) async {
    
    final idAgendamento = atividade.idAgendamentoAtividadeFeira;
    final bool isCheckedIn = isMonitorCheckedIn(idAgendamento);
    final String statusFinal = isCheckedIn ? "CONCLUIDA" : "EM_ANDAMENTO";

    
    final PontoAtividadeDto ponto = PontoAtividadeDto(
      idMonitor: atividade.idMonitor,
      idAgendamentoAtividadeFeira: idAgendamento,
      horarioAcao: DateTime.now(),
      nomeAtividade: atividade.nomeAtividade,
      turno: atividade.turno,
      nomeDaFeira: atividade.nomeDaFeira,
      novoStatus: statusFinal,
    );

    await Future.delayed(const Duration(milliseconds: 500)); 
    print("MOCK API SUCESSO. DTO ENVIADO: ${ponto.toJson()}");

    _checkInStatus[idAgendamento] = !isCheckedIn;
    
    return ponto;
  }
}

final PontoService pontoService = PontoService();