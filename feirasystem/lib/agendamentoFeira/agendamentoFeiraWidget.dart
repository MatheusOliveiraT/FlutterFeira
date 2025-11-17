import 'package:feirasystem/agendamentoFeira/agendamentoFeiraModel.dart';
import 'package:feirasystem/agendamentoFeira/agendamentoFeiraService.dart';
import 'package:feirasystem/assets/bottomAppBarOrganizador.dart';
import 'package:feirasystem/feira/feiraModel.dart';
import 'package:feirasystem/feira/feiraService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AgendamentosFeira extends StatefulWidget {
  const AgendamentosFeira({super.key});
  @override
  _AgendamentosFeiraState createState() => _AgendamentosFeiraState();
}

class _AgendamentosFeiraState extends State<AgendamentosFeira> {
  final AgendamentoFeiraService _agendamentoFeiraService =
      AgendamentoFeiraService();
  final FeiraService _feiraService = FeiraService();
  late Future<List<Feira>> _feiras;
  late Future<List<AgendamentoFeira>> _agendamentosFeira;

  final TextEditingController _controladorData = TextEditingController();
  Feira? _feiraSelecionada;
  Turno? _turnoSelecionado;

  @override
  void initState() {
    super.initState();
    _atualizarFeiras();
    _atualizarAgendamentosFeira();
  }

  @override
  void dispose() {
    _controladorData.dispose();
    super.dispose();
  }

  bool _validarForm() {
    String nome = _controladorData.text;
    if (nome.isEmpty ||
        _feiraSelecionada == null ||
        _turnoSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Preencha todos os campos obrigatórios!'),
            duration: Duration(seconds: 1)),
      );
      return false;
    }
    return true;
  }

  Future<void> _selecionarData(BuildContext context, {DateTime? data}) async {
    if (data != null) {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: data,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (pickedDate != null) {
        String formattedDateTime = DateFormat('dd/MM/yyyy').format(pickedDate);

        setState(() {
          _controladorData.text = formattedDateTime;
        });
      }
    } else {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (pickedDate != null) {
        String formattedDateTime = DateFormat('dd/MM/yyyy').format(pickedDate);

        setState(() {
          _controladorData.text = formattedDateTime;
        });
      }
    }
  }

  Future<void> _atualizarAgendamentosFeira() async {
    setState(() {
      _agendamentosFeira = _agendamentoFeiraService.getAgendamentos();
    });
  }

  Future<void> _atualizarFeiras() async {
    setState(() {
      _feiras = _feiraService.getFeiras();
    });
  }

  Future<void> _mostrarFormAgendamentoFeira(
      {AgendamentoFeira? agendamentoFeira}) async {
    if (agendamentoFeira != null) {
      _controladorData.text =
          DateFormat('dd/MM/yyyy').format(agendamentoFeira.data);
      _feiras.then((lista) {
        _feiraSelecionada =
            lista.firstWhere((feira) => feira.id == agendamentoFeira.idFeira);
      });
      _turnoSelecionado = agendamentoFeira.turno;
    } else {
      _controladorData.clear();
      _feiraSelecionada = null;
      _turnoSelecionado = null;
    }
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text(agendamentoFeira == null
                  ? 'Criar agendamento de feira'
                  : 'Editar agendamento de feira'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FutureBuilder<List<Feira>>(
                      future: _feiras,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Erro: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Text('Nenhuma feira encontrada');
                        } else {
                          final feiras = snapshot.data!;
                          return DropdownButtonFormField<Feira>(
                            initialValue: _feiraSelecionada,
                            hint: const Text("Selecione uma feira"),
                            items: feiras.map((Feira feira) {
                              return DropdownMenuItem<Feira>(
                                value: feira,
                                child: Text(feira.nome),
                              );
                            }).toList(),
                            onChanged: (Feira? novaFeira) {
                              setStateDialog(() {
                                _feiraSelecionada = novaFeira;
                              });
                            },
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<Turno>(
                      initialValue: _turnoSelecionado,
                      hint: const Text("Selecione um turno"),
                      items: Turno.values.map((Turno turno) {
                        return DropdownMenuItem<Turno>(
                          value: turno,
                          child: Text(turno.descricao),
                        );
                      }).toList(),
                      onChanged: (Turno? novoTurno) {
                        setStateDialog(() {
                          _turnoSelecionado = novoTurno;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _controladorData,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Selecione a data',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      onTap: () => {
                        if (agendamentoFeira != null)
                          {
                            _selecionarData(context,
                                data: agendamentoFeira.data)
                          }
                        else
                          {_selecionarData(context)}
                      },
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
                      final newAgendamentoFeira = AgendamentoFeira(
                          data: DateFormat('dd/MM/yyyy')
                              .parse(_controladorData.text),
                          turno: _turnoSelecionado!,
                          idFeira: _feiraSelecionada!.id!);
                      if (agendamentoFeira != null) {
                        await _agendamentoFeiraService.updateAgendamento(
                            agendamentoFeira.id!, newAgendamentoFeira);
                      } else {
                        await _agendamentoFeiraService
                            .createAgendamento(newAgendamentoFeira);
                      }
                      Navigator.pop(context);
                      _atualizarAgendamentosFeira();
                      final snackBar = SnackBar(
                        content: Text(
                            'Agendamento de feira ${agendamentoFeira == null ? 'criado' : 'atualizado'} com sucesso!'),
                        duration: const Duration(seconds: 2),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Text(agendamentoFeira == null ? 'Criar' : 'Atualizar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _deleteAgendamentoFeira(
      AgendamentoFeira agendamentoFeira) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir agendamento de feira'),
        content: const Text(
            'Você tem certeza que quer excluir este agendamento de feira?'),
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
      await _agendamentoFeiraService.deleteAgendamento(agendamentoFeira.id!);
      _atualizarAgendamentosFeira();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Agendamento de feira excluído com sucesso.'),
            duration: Duration(seconds: 2)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendamento de feira'),
      ),
      body: RefreshIndicator(
        onRefresh: _atualizarAgendamentosFeira,
        child: FutureBuilder<List<dynamic>>(
          future: Future.wait([_agendamentosFeira, _feiras]),
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

            final List<AgendamentoFeira> agendamentosFeira = snapshot.data![0];
            final List<Feira> feiras = snapshot.data![1];

            return ListView.builder(
              itemCount: agendamentosFeira.length,
              itemBuilder: (context, index) {
                final agendamentoFeira = agendamentosFeira[index];
                return Dismissible(
                  key: Key(agendamentoFeira.id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) => _deleteAgendamentoFeira(agendamentoFeira),
                  child: ListTile(
                    title: Text(feiras
                        .firstWhere(
                            (feira) => feira.id == agendamentoFeira.idFeira)
                        .nome),
                    subtitle: Text(
                      'Data: ${DateFormat('dd/MM/yyyy').format(agendamentoFeira.data)}\nTurno: ${agendamentoFeira.turno.descricao}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _mostrarFormAgendamentoFeira(
                              agendamentoFeira: agendamentoFeira),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () =>
                              _deleteAgendamentoFeira(agendamentoFeira),
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
        onPressed: () => _mostrarFormAgendamentoFeira(),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomAppBarOrganizador(),
    );
  }
}
