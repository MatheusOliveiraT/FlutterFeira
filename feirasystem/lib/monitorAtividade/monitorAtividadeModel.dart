// lib/monitorAtividade/monitorAtividadeModel.dart

class MonitorAtividade {
  final int? id;
  final bool estevePresente;
  final int idMonitor;
  final int idAgendamentoAtividadeFeira;

  final String nomeAtividade;
  final String turno;
  final String nomeDaFeira;
  

  MonitorAtividade({
    this.id,
    required this.estevePresente,
    required this.idMonitor,
    required this.idAgendamentoAtividadeFeira,
    required this.nomeAtividade,
    required this.turno,
    required this.nomeDaFeira,
  });

  factory MonitorAtividade.fromJson(Map<String, dynamic> json) {
    return MonitorAtividade(
      id: int.parse(json['id'].toString()),
      estevePresente: bool.parse(json['estevePresente'].toString()),
      idMonitor: int.parse(json['idMonitor'].toString()),
      idAgendamentoAtividadeFeira:
          int.parse(json['idAgendamentoAtividadeFeira'].toString()),
      
      nomeAtividade: json['nomeAtividade'] ?? 'Atividade Sem Nome',
      turno: json['turno'] ?? 'Turno Padrão',
      nomeDaFeira: json['nomeDaFeira'] ?? 'Feira Padrão',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'estevePresente': estevePresente,
      'idMonitor': idMonitor,
      'idAgendamentoAtividadeFeira': idAgendamentoAtividadeFeira,
      'nomeAtividade': nomeAtividade,
      'turno': turno,
      'nomeDaFeira': nomeDaFeira,
    };
  }
}