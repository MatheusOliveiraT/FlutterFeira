class AgendamentoAtividadeFeira {
  final int? id;
  final int quantidadeMonitoresInscrito;
  final int idAgendamentoFeira;
  final int idAtividade;

  AgendamentoAtividadeFeira(
      {this.id,
      required this.quantidadeMonitoresInscrito,
      required this.idAgendamentoFeira,
      required this.idAtividade});

  @override
  String toString() {
    return 'AgendamentoAtividadeFeira {\nid: $id, \nquantidadeMonitoresInscrito: $quantidadeMonitoresInscrito, \nidAgendamentoFeira: $idAgendamentoFeira, \nidAtividade: $idAtividade\n}';
  }

  factory AgendamentoAtividadeFeira.fromJson(Map<String, dynamic> json) {
    return AgendamentoAtividadeFeira(
      id: int.parse(json['id'].toString()),
      quantidadeMonitoresInscrito:
          int.parse(json['quantidadeMonitoresInscrito'].toString()),
      idAgendamentoFeira: int.parse(json['AgendamentoFeira'].toString()),
      idAtividade: int.parse(json['idAtividade'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quantidadeMonitoresInscrito': quantidadeMonitoresInscrito,
      'idAgendamentoFeira': idAgendamentoFeira,
      'idAtividade': idAtividade,
    };
  }
}
