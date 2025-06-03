class MonitorAtividade {
  final int? id;
  final bool estevePresente;
  final int idMonitor;
  final int idAgendamentoAtividadeFeira;

  MonitorAtividade(
      {this.id,
      required this.estevePresente,
      required this.idMonitor,
      required this.idAgendamentoAtividadeFeira});

  factory MonitorAtividade.fromJson(Map<String, dynamic> json) {
    return MonitorAtividade(
      id: int.parse(json['id'].toString()),
      estevePresente: bool.parse(json['estevePresente'].toString()),
      idMonitor: int.parse(json['idMonitor'].toString()),
      idAgendamentoAtividadeFeira:
          int.parse(json['idAgendamentoAtividadeFeira'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'estevePresente': estevePresente,
      'idMonitor': idMonitor,
      'idAgendamentoAtividadeFeira': idAgendamentoAtividadeFeira,
    };
  }
}
