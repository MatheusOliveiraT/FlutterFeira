import 'package:feirasystem/agendamentoAtividadeFeira/agendamentoAtividadeFeiraModel.dart';
import 'package:feirasystem/agendamentoAtividadeFeira/agendamentoAtividadeFeiraService.dart';
import 'package:feirasystem/assets/bottomAppBarOrganizador.dart';
import 'package:feirasystem/atividade/atividadeModel.dart';
import 'package:feirasystem/atividade/atividadeService.dart';
import 'package:feirasystem/monitorAtividade/monitorAtividadeModel.dart';
import 'package:feirasystem/monitorAtividade/monitorAtividadeService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetalhesAgendamentosAtividadeFeira extends StatefulWidget {
  final AgendamentoAtividadeFeira agendamento;
  final Function(dynamic context) builder;

  const DetalhesAgendamentosAtividadeFeira(
      {super.key, required this.agendamento, required this.builder});

  @override
  _DetalhesAgendamentosAtividadeFeiraState createState() =>
      _DetalhesAgendamentosAtividadeFeiraState();
}

class _DetalhesAgendamentosAtividadeFeiraState
    extends State<DetalhesAgendamentosAtividadeFeira> {
  final AgendamentoAtividadeFeiraService _agendamentoAtividadeFeiraService =
      AgendamentoAtividadeFeiraService();
  final AtividadeService _atividadeService = AtividadeService();
  final MonitorAtividadeService _monitorAtividadeService =
      MonitorAtividadeService();
  // pessoaService

  late final AgendamentoAtividadeFeira agendamento;
  Atividade? atividade;
  List<MonitorAtividade> monitores = [];

  @override
  void initState() {
    super.initState();
    agendamento = widget.agendamento;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: BottomAppBarOrganizador(),
    );
  }
}
