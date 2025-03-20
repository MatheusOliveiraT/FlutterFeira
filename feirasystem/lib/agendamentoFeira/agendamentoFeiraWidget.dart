import 'package:feirasystem/agendamentoFeira/agendamentoFeiraModel.dart';
import 'package:feirasystem/feira/feiraModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AgendamentosFeira extends StatefulWidget {
  const AgendamentosFeira({super.key});
  @override
  _AgendamentosFeiraState createState() => _AgendamentosFeiraState();
}

class _AgendamentosFeiraState extends State<AgendamentosFeira> {
  final List<Feira> _feiras = [
    Feira(id: 0, nome: 'Feira das Profissões 2025'),
    Feira(id: 1, nome: 'Feira das Profissões 2026'),
  ];
  List<AgendamentoFeira> _agendamentosFeira = [];

  final TextEditingController _controladorData = TextEditingController();
  Feira? _feiraSelecionada;
  Turno? _turnoSelecionado;

  @override
  void initState() {
    super.initState();
    _agendamentosFeira = [
      AgendamentoFeira(0, DateTime.utc(2025, 08, 27), Turno.MANHA,
          _feiras.firstWhere((l) => l.id == 0)),
      AgendamentoFeira(1, DateTime.utc(2025, 08, 27), Turno.TARDE,
          _feiras.firstWhere((l) => l.id == 0)),
      AgendamentoFeira(2, DateTime.utc(2025, 08, 28), Turno.MANHA,
          _feiras.firstWhere((l) => l.id == 0)),
      AgendamentoFeira(3, DateTime.utc(2025, 08, 28), Turno.TARDE,
          _feiras.firstWhere((l) => l.id == 0)),
    ];
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
      // RETRIEVE
    });
  }

  void _mostrarFormAgendamentoFeira({AgendamentoFeira? agendamentoFeira}) {
    if (agendamentoFeira != null) {
      _controladorData.text =
          DateFormat('dd/MM/yyyy').format(agendamentoFeira.data);
      _feiraSelecionada = agendamentoFeira.feira;
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
                    DropdownButton<Feira>(
                      value: _feiraSelecionada,
                      hint: const Text("Selecione uma feira"),
                      items: _feiras.map((Feira feira) {
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
                    ),
                    DropdownButton<Turno>(
                      value: _turnoSelecionado,
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
                    TextField(
                      controller: _controladorData,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Selecione a data',
                        suffixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
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
                  onPressed: () {
                    if (_validarForm()) {
                      if (agendamentoFeira != null) {
                        // UPDATE
                      } else {
                        // CREATE
                      }
                      Navigator.pop(context);
                      final snackBar = SnackBar(
                        content: Text(
                            '${agendamentoFeira == null ? 'Agendamento de feira criado' : 'Agendamento de feira atualizado'} com sucesso!'),
                        duration:
                            const Duration(seconds: 2), // Duração da mensagem
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
      // DELETE
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Agendamento de feira excluída com sucesso.'),
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
        child: ListView.builder(
          itemCount: _agendamentosFeira.length,
          itemBuilder: (context, index) {
            final agendamentoFeira = _agendamentosFeira[index];
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
                title: Text(agendamentoFeira.feira.nome),
                subtitle: Text(
                  'Data: ${DateFormat('dd/MM/yyyy').format(agendamentoFeira.data)}\nTurno: ${agendamentoFeira.turno.descricao}',
                ),
                trailing: Row(
                  mainAxisSize:
                      MainAxisSize.min, // Makes the Row take minimum space
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarFormAgendamentoFeira(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
