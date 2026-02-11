import 'package:dio/dio.dart';
import 'monitorAtividadeModel.dart'; 
import 'ponto_atividade_dto.dart'; 
import 'dart:async'; 

class PontoService {
  final Dio _dio = Dio();
  final Map<int, bool> _checkInStatus = {};

  // ⚠️ Mesmo IP e Porta do outro arquivo
  final String baseUrl = 'http://localhost:3000';

  bool isMonitorCheckedIn(int idAgendamento) {
    return _checkInStatus[idAgendamento] ?? false;
  }

  Future<PontoAtividadeDto> registrarPonto({
    required MonitorAtividade atividade,
  }) async {
    
    
    final int idRegistro = atividade.id!; 
    final idAgendamento = atividade.idAgendamentoAtividadeFeira;
    final bool isCheckedIn = isMonitorCheckedIn(idAgendamento);
    
    // LÓGICA DE HORÁRIO
    // Se não fez checkin -> Manda horaEntrada
    // Se já fez checkin -> Manda horaSaida
    Map<String, dynamic> bodyBackend;
    String novoStatusVisual;

    if (!isCheckedIn) {
      // Fazendo Check-in
      bodyBackend = {
        "horaEntrada": DateTime.now().toIso8601String()
      };
      novoStatusVisual = "EM_ANDAMENTO";
    } else {
      // Fazendo Checkout
      bodyBackend = {
        "horaSaida": DateTime.now().toIso8601String()
      };
      novoStatusVisual = "CONCLUIDA";
    }

    try {
      print("Enviando PUT para: $baseUrl/monitores/atividade/$idRegistro");
      print("Dados: $bodyBackend");

      // ENVIO REAL (PUT)
      await _dio.put(
        '$baseUrl/monitores/atividade/$idRegistro', 
        data: bodyBackend
      );

      // SUCESSO
      _checkInStatus[idAgendamento] = !isCheckedIn;
      
      // Retorna o DTO apenas para o Front atualizar a cor do botão
      return PontoAtividadeDto(
        idMonitor: atividade.idMonitor,
        idAgendamentoAtividadeFeira: idAgendamento,
        horarioAcao: DateTime.now(),
        nomeAtividade: atividade.nomeAtividade,
        turno: atividade.turno,
        nomeDaFeira: atividade.nomeDaFeira,
        novoStatus: novoStatusVisual,
      );

    } catch (e) {
      print("Erro ao enviar ponto: $e");
      throw Exception("Falha na comunicação com o servidor.");
    }
  }
}

final PontoService pontoService = PontoService();