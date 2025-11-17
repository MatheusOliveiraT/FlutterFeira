import 'package:feirasystem/agendamentoAtividadeFeira/detalhesAgendamentoAtividadeFeiraWidget.dart';
import 'package:feirasystem/agendamentoFeira/agendamentoFeiraModel.dart';
import 'package:feirasystem/agendamentoFeira/agendamentoFeiraService.dart';
import 'package:feirasystem/assets/customSnackBar.dart';
import 'package:feirasystem/atividade/atividadeModel.dart';
import 'package:feirasystem/atividade/atividadeService.dart';
import 'package:feirasystem/agendamentoAtividadeFeira/agendamentoAtividadeFeiraModel.dart';
import 'package:feirasystem/agendamentoAtividadeFeira/agendamentoAtividadeFeiraService.dart';
import 'package:feirasystem/assets/bottomAppBarOrganizador.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AgendamentosAtividadeFeira extends StatefulWidget {
  const AgendamentosAtividadeFeira({super.key});
  @override
  _AgendamentosAtividadeFeiraState createState() =>
      _AgendamentosAtividadeFeiraState();
}

class _AgendamentosAtividadeFeiraState
    extends State<AgendamentosAtividadeFeira> {
  final AgendamentoFeiraService _agendamentoFeiraService =
      AgendamentoFeiraService();
  final AtividadeService _atividadeService = AtividadeService();
  final AgendamentoAtividadeFeiraService _agendamentoAtividadeFeiraService =
      AgendamentoAtividadeFeiraService();
  late Future<List<AgendamentoFeira>> _agendamentosFeira;
  late Future<List<Atividade>> _atividades;
  late Future<List<AgendamentoAtividadeFeira>> _agendamentosAtividadeFeira;

  List<AgendamentoFeira> _agendamentos = [];
  List<AgendamentoFeira> _agendamentosSelecionados = [];
  Atividade? _atividadeSelecionada;
  int _maxAgendamentosPermitidos = 999;

  @override
  void initState() {
    super.initState();
    _atualizarAgendamentosFeira();
    _atualizarAtividades();
    _atualizarAgendamentosAtividadeFeira();
  }

  bool _validarForm() {
    if (_agendamentosSelecionados.isEmpty || _atividadeSelecionada == null) {
      showCustomSnackBar(context, 'Preencha todos os campos obrigatórios!',
          tipo: 'erro');
      return false;
    }
    return true;
  }

  Future<void> _atualizarAgendamentosFeira() async {
    setState(() {
      _agendamentosFeira = _agendamentoFeiraService.getAgendamentos();
    });
  }

  Future<void> _atualizarAtividades() async {
    setState(() {
      _atividades = _atividadeService.getAtividades();
    });
  }

  Future<void> _atualizarAgendamentosAtividadeFeira() async {
    setState(() {
      _agendamentosAtividadeFeira =
          _agendamentoAtividadeFeiraService.getAgendamentos();
    });
  }

  Future<void> _atualizarAgendamentos(int idFeira) async {
    setState(() {
      _agendamentos = [];
      _agendamentosSelecionados = [];
    });
    final agendamentos = await _agendamentosFeira;
    _agendamentos = agendamentos.where((a) => a.idFeira == idFeira).toList();
  }

  Future<void> _mostrarFormAgendamentoAtividadeFeira(
      {AgendamentoAtividadeFeira? agendamentoAtividadeFeira}) async {
    if (agendamentoAtividadeFeira != null) {
      _agendamentosFeira.then((lista) {
        _agendamentosSelecionados = lista.firstWhere((agendamento) =>
                agendamento.id == agendamentoAtividadeFeira.idAgendamentoFeira)
            as List<AgendamentoFeira>;
      });
      _atividades.then((lista) {
        _atividadeSelecionada = lista.firstWhere((atividade) =>
            atividade.id == agendamentoAtividadeFeira.idAtividade);
      });
      _maxAgendamentosPermitidos = 1;
    } else {
      _agendamentosSelecionados = [];
      _atividadeSelecionada = null;
      _maxAgendamentosPermitidos = 999;
    }
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text(agendamentoAtividadeFeira == null
                  ? 'Criar agendamento de atividade de feira'
                  : 'Editar agendamento de atividade de feira'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FutureBuilder<List<Atividade>>(
                        future: _atividades,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Erro: ${snapshot.error}');
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Text('Nenhuma atividade encontrada');
                          } else {
                            final atividades = snapshot.data!;
                            return DropdownButtonFormField<Atividade>(
                              initialValue: _atividadeSelecionada,
                              hint: const Text("Selecione uma atividade"),
                              items: atividades.map((Atividade atividade) {
                                return DropdownMenuItem<Atividade>(
                                  value: atividade,
                                  child: Text(atividade.nome),
                                );
                              }).toList(),
                              onChanged: (Atividade? novaAtividade) {
                                setStateDialog(() {
                                  _atividadeSelecionada = novaAtividade;
                                });
                                if (novaAtividade != null) {
                                  _atualizarAgendamentos(novaAtividade.idFeira);
                                }
                              },
                            );
                          }
                        }),
                    const SizedBox(height: 10),
                    MultiSelectDialogField<AgendamentoFeira>(
                      items: _agendamentos
                          .map((e) => MultiSelectItem<AgendamentoFeira>(e,
                              '${DateFormat('dd/MM/yyyy').format(e.data)} ${e.turno.descricao}'))
                          .toList(),
                      title: const Text("Agendamentos de Feira"),
                      buttonText: const Text("Selecione os agendamentos"),
                      initialValue: _agendamentosSelecionados,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey),
                      ),
                      selectedColor: const Color.fromARGB(255, 50, 136, 242),
                      confirmText: const Text(
                        "Salvar",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      cancelText: const Text(
                        "Cancelar",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      onConfirm: (values) {
                        if (values.length > _maxAgendamentosPermitidos) {
                          showCustomSnackBar(
                            context,
                            'Você só pode selecionar até $_maxAgendamentosPermitidos agendamento${_maxAgendamentosPermitidos == 1 ? '' : 's'}.',
                            tipo: 'erro',
                          );
                        } else {
                          setStateDialog(() {
                            _agendamentosSelecionados = values;
                          });
                        }
                      },
                      validator: (values) {
                        if (values == null || values.isEmpty) {
                          return 'Selecione pelo menos um agendamento.';
                        } else if (values.length > _maxAgendamentosPermitidos) {
                          return 'Máximo de $_maxAgendamentosPermitidos selecionado${_maxAgendamentosPermitidos == 1 ? '' : 's'}.';
                        }
                        return null;
                      },
                      chipDisplay: MultiSelectChipDisplay(
                        onTap: (item) {
                          setStateDialog(() {
                            _agendamentosSelecionados.remove(item);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Voltar'),
                ),
                TextButton(
                  onPressed: () async {
                    if (_validarForm()) {
                      int quantidadeMonitores = agendamentoAtividadeFeira
                              ?.quantidadeMonitoresInscrito ??
                          0;
                      if (agendamentoAtividadeFeira != null) {
                        final novo = AgendamentoAtividadeFeira(
                          quantidadeMonitoresInscrito: quantidadeMonitores,
                          idAgendamentoFeira:
                              _agendamentosSelecionados.first.id!,
                          idAtividade: _atividadeSelecionada!.id!,
                        );
                        await _agendamentoAtividadeFeiraService
                            .updateAgendamento(
                          agendamentoAtividadeFeira.id!,
                          novo,
                        );
                      } else {
                        for (final agendamento in _agendamentosSelecionados) {
                          final novo = AgendamentoAtividadeFeira(
                            quantidadeMonitoresInscrito: 0,
                            idAgendamentoFeira: agendamento.id!,
                            idAtividade: _atividadeSelecionada!.id!,
                          );
                          await _agendamentoAtividadeFeiraService
                              .createAgendamento(novo);
                        }
                      }
                      Navigator.pop(context);
                      _atualizarAgendamentosFeira();
                      showCustomSnackBar(
                        context,
                        'Agendamento de atividade de feira ${agendamentoAtividadeFeira == null ? 'criado' : 'atualizado'} com sucesso!',
                        tipo: 'sucesso',
                      );
                    }
                  },
                  child: Text(agendamentoAtividadeFeira == null
                      ? 'Criar'
                      : 'Atualizar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _deleteAgendamentoAtividadeFeira(
      AgendamentoAtividadeFeira agendamentoAtividadeFeira) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir agendamento de atividade de feira'),
        content: const Text(
            'Você tem certeza que quer excluir este agendamento de atividade de feira?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
    if (confirm == true) {
      await _agendamentoAtividadeFeiraService
          .deleteAgendamento(agendamentoAtividadeFeira.id!);
      _atualizarAgendamentosFeira();
      showCustomSnackBar(
          context, 'Agendamento de atividade de feira excluído com sucesso.',
          tipo: 'sucesso');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendamento de atividade de feira'),
      ),
      body: RefreshIndicator(
        onRefresh: _atualizarAgendamentosAtividadeFeira,
        child: FutureBuilder<List<dynamic>>(
          future: Future.wait(
              [_agendamentosAtividadeFeira, _agendamentosFeira, _atividades]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                  child: Text('Nenhum agendamento encontrado.'));
            }

            final List<AgendamentoAtividadeFeira> agendamentosAtividadeFeira =
                snapshot.data![0];
            final List<AgendamentoFeira> agendamentosFeira = snapshot.data![1];
            final List<Atividade> atividades = snapshot.data![2];

            return ListView.builder(
              itemCount: agendamentosAtividadeFeira.length,
              itemBuilder: (context, index) {
                final agendamentoAtividadeFeira =
                    agendamentosAtividadeFeira[index];
                return Dismissible(
                  key: Key(agendamentoAtividadeFeira.id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) => _deleteAgendamentoAtividadeFeira(
                      agendamentoAtividadeFeira),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetalhesAgendamentosAtividadeFeira(
                            agendamento: agendamentoAtividadeFeira,
                            builder: (context) {},
                          ),
                        ),
                      );
                    },
                    title: Text(atividades
                        .firstWhere((atividade) =>
                            atividade.id ==
                            agendamentoAtividadeFeira.idAtividade)
                        .nome),
                    subtitle: Text(
                        'Data: ${DateFormat('dd/MM/yyyy').format(agendamentosFeira.firstWhere((agendamentoFeira) => agendamentoFeira.id == agendamentoAtividadeFeira.idAgendamentoFeira).data)}\nTurno: ${agendamentosFeira.firstWhere((agendamentoFeira) => agendamentoFeira.id == agendamentoAtividadeFeira.idAgendamentoFeira).turno.descricao}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () =>
                              _mostrarFormAgendamentoAtividadeFeira(
                                  agendamentoAtividadeFeira:
                                      agendamentoAtividadeFeira),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteAgendamentoAtividadeFeira(
                              agendamentoAtividadeFeira),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarFormAgendamentoAtividadeFeira(),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomAppBarOrganizador(),
    );
  }
}
