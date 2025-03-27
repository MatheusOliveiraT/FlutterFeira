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
    return 'Atividade{\nid: $id, \nquantidadeMonitoresInscrito: $quantidadeMonitoresInscrito, \nidAgendamentoFeira: $idAgendamentoFeira, \nidAtividade: $idAtividade\n}';
  }
}
