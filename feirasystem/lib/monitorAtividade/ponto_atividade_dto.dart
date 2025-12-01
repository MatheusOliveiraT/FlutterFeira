// lib/monitorAtividade/ponto_atividade_dto.dart

class PontoAtividadeDto {
  
  final int idMonitor;       
  final int idAgendamentoAtividadeFeira; 
  
  
  final DateTime horarioAcao; // Substitui 'horario'
  final String nomeAtividade;
  final String turno;
  final String nomeDaFeira;
  final String novoStatus; // Substitui 'tipoRegistro'

  PontoAtividadeDto({
    required this.idMonitor,
    required this.idAgendamentoAtividadeFeira,
    required this.horarioAcao,
    required this.nomeAtividade,
    required this.turno,
    required this.nomeDaFeira,
    required this.novoStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      'idMonitor': idMonitor,
      'idAgendamentoAtividadeFeira': idAgendamentoAtividadeFeira,
      'horarioAcao': horarioAcao.toIso8601String(),
      'nomeAtividade': nomeAtividade,
      'turno': turno,
      'nomeDaFeira': nomeDaFeira,
      'novoStatus': novoStatus,
    };
  }
}