class MonitorAtividade {
  final int id;
  final bool estevePresente;
  final int idMonitor;
  final int idAgendamentoAtividadeFeira;
  final int idAtividadeReal; // NOVO: Precisamos do ID da sala para alterá-la
  final String statusAtividade; // NOVO: "OCIOSA" ou "OCUPADA"
  final String nomeAtividade;
  final String turno;
  final String nomeDaFeira;
  final String? horaEntrada;
  final String? horaSaida;

  MonitorAtividade({
    required this.id,
    required this.estevePresente,
    required this.idMonitor,
    required this.idAgendamentoAtividadeFeira,
    required this.idAtividadeReal,
    required this.statusAtividade,
    required this.nomeAtividade,
    required this.turno,
    required this.nomeDaFeira,
    this.horaEntrada,
    this.horaSaida,
  });

  factory MonitorAtividade.fromJson(Map<String, dynamic> json) {
    var agendamento = json['agendamentoAtividadeFeira'] ?? {};
    var atividade = agendamento['atividade'] ?? {};
    var feira = agendamento['feira'] ?? {};
    var pessoa = json['pessoa'] ?? {};

    return MonitorAtividade(
      id: json['id'],
      estevePresente: json['horaEntrada'] != null,
      idMonitor: pessoa['id'] ?? 0,
      idAgendamentoAtividadeFeira: agendamento['id'] ?? 0,
      
      
      idAtividadeReal: atividade['id'] ?? 0, 
      statusAtividade: atividade['status'] ?? "OCIOSA", 
      
      nomeAtividade: atividade['nome'] ?? "Carregando...",
      turno: agendamento['turno'] ?? "Não definido",
      nomeDaFeira: feira['nome'] ?? "Feira",
      horaEntrada: json['horaEntrada'],
      horaSaida: json['horaSaida'],
    );
  }
}