import 'package:feirasystem/assets/bottomAppBarOrganizador.dart';
import 'package:feirasystem/atividade/atividadeModel.dart';
import 'package:feirasystem/atividade/atividadeService.dart';
import 'package:feirasystem/feira/feiraModel.dart';
import 'package:feirasystem/feira/feiraService.dart';
import 'package:feirasystem/localidade/localidadeModel.dart';
import 'package:feirasystem/localidade/localidadeService.dart';
import 'package:feirasystem/professor/professorModel.dart';
import 'package:feirasystem/professor/professorService.dart';
import 'package:feirasystem/sublocalidade/sublocalidadeModel.dart';
import 'package:feirasystem/sublocalidade/sublocalidadeService.dart';
import 'package:flutter/material.dart';

class Atividades extends StatefulWidget {
  const Atividades({super.key});
  @override
  _AtividadesState createState() => _AtividadesState();
}

class _AtividadesState extends State<Atividades> {
  final AtividadeLocalidadeService _atividadeLocalidadeService =
      AtividadeLocalidadeService();
  final AtividadeSublocalidadeService _atividadeSublocalidadeService =
      AtividadeSublocalidadeService();
  final FeiraService _feiraService = FeiraService();
  final ProfessorService _professorService = ProfessorService();
  final LocalidadeService _localidadeService = LocalidadeService();
  final SublocalidadeService _sublocalidadeService = SublocalidadeService();
  late Future<List<AtividadeLocalidade>> _atividadesLocalidade;
  late Future<List<AtividadeSublocalidade>> _atividadesSublocalidade;
  late Future<List<Feira>> _feiras;
  late Future<List<Professor>> _professores;
  late Future<List<Localidade>> _localidades;
  late Future<List<Sublocalidade>> _sublocalidades;

  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorDescricao = TextEditingController();
  final TextEditingController _controladorQuantidadeMonitores =
      TextEditingController();
  final TextEditingController _controladorDuracaoSecao =
      TextEditingController();
  final TextEditingController _controladorCapacidadeVisitantes =
      TextEditingController();
  Feira? _feiraSelecionada;
  Professor? _professorSelecionado;
  Localidade? _localidadeSelecionada;
  Sublocalidade? _sublocalidadeSelecionada;
  Status? _status;
  Tipo? _tipo;
  String _opcaoSelecionada = 'Selecione uma opção';

  @override
  void initState() {
    super.initState();
    _atualizarFeiras();
    _atualizarProfessores();
    _atualizarLocalidades();
    _atualizarSublocalidades();
    _atualizarAtividades();
  }

  @override
  void dispose() {
    _controladorNome.dispose();
    _controladorDescricao.dispose();
    _controladorQuantidadeMonitores.dispose();
    _controladorDuracaoSecao.dispose();
    _controladorCapacidadeVisitantes.dispose();
    super.dispose();
  }

  Future<void> _atualizarFeiras() async {
    setState(() {
      _feiras = _feiraService.getFeiras();
    });
  }

  Future<void> _atualizarProfessores() async {
    setState(() {
      _professores = _professorService.getProfessores();
    });
  }

  Future<void> _atualizarLocalidades() async {
    setState(() {
      _localidades = _localidadeService.getLocalidades();
    });
  }

  Future<void> _atualizarSublocalidades() async {
    setState(() {
      _sublocalidades = _sublocalidadeService.getSublocalidades();
    });
  }

  Future<void> _atualizarAtividades() async {
    setState(() {
      _atividadesLocalidade = _atividadeLocalidadeService.getAtividades();
      _atividadesSublocalidade = _atividadeSublocalidadeService.getAtividades();
    });
  }

  bool _validarForm() {
    String nome = _controladorNome.text.trim();
    String descricao = _controladorDescricao.text.trim();
    String quantidadeMonitores = _controladorQuantidadeMonitores.text.trim();
    if (nome.isEmpty ||
        descricao.isEmpty ||
        quantidadeMonitores.isEmpty ||
        _feiraSelecionada == null ||
        _professorSelecionado == null) {
      _mostrarSnackBar('Preencha todos os campos obrigatórios!');
      return false;
    }
    if (int.tryParse(quantidadeMonitores) == null) {
      _mostrarSnackBar(
          'Quantidade de monitores precisa ser um número inteiro.');
      return false;
    }
    if (_opcaoSelecionada == 'Localidade') {
      if (_localidadeSelecionada == null) {
        _mostrarSnackBar('Preencha todos os campos obrigatórios!');
        return false;
      }
    } else if (_opcaoSelecionada == 'Sublocalidade') {
      String duracaoSecao = _controladorDuracaoSecao.text.trim();
      String capacidadeVisitantes =
          _controladorCapacidadeVisitantes.text.trim();
      if (duracaoSecao.isEmpty ||
          capacidadeVisitantes.isEmpty ||
          _sublocalidadeSelecionada == null ||
          _tipo == null ||
          _status == null) {
        _mostrarSnackBar('Preencha todos os campos obrigatórios!');
        return false;
      } else if (int.tryParse(duracaoSecao) == null ||
          int.tryParse(capacidadeVisitantes) == null) {
        _mostrarSnackBar(
            'Duração da seção e capacidade de visitantes precisam ser um número inteiro.');
        return false;
      }
    } else {
      _mostrarSnackBar('Preencha todos os campos obrigatórios!');
      return false;
    }
    return true;
  }

  void _mostrarSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _mostrarFormAtividades(
      {AtividadeLocalidade? atividadeLocalidade,
      AtividadeSublocalidade? atividadeSublocalidade}) async {
    if (atividadeLocalidade != null) {
      _controladorNome.text = atividadeLocalidade.nome;
      _controladorDescricao.text = atividadeLocalidade.descricao;
      _controladorQuantidadeMonitores.text =
          atividadeLocalidade.quantidadeMonitores.toString();
      _controladorCapacidadeVisitantes.clear();
      _controladorDuracaoSecao.clear();
      _localidades.then((lista) {
        _localidadeSelecionada = lista.firstWhere(
            (localidade) => localidade.id == atividadeLocalidade.idLocalidade);
      });
      _sublocalidadeSelecionada = null;
      _professores.then((lista) {
        _professorSelecionado = lista.firstWhere(
            (professor) => professor.id == atividadeLocalidade.idProfessor);
      });
      _feiras.then((lista) {
        _feiraSelecionada = lista
            .firstWhere((feira) => feira.id == atividadeLocalidade.idFeira);
      });
      _status = null;
      _tipo = null;
      _opcaoSelecionada = 'Localidade';
    } else if (atividadeSublocalidade != null) {
      _controladorNome.text = atividadeSublocalidade.nome;
      _controladorDescricao.text = atividadeSublocalidade.descricao;
      _controladorQuantidadeMonitores.text =
          atividadeSublocalidade.quantidadeMonitores.toString();
      _controladorCapacidadeVisitantes.text =
          atividadeSublocalidade.capacidadeVisitantes.toString();
      _controladorDuracaoSecao.text =
          atividadeSublocalidade.duracaoSecao.toString();
      _localidadeSelecionada = null;
      _sublocalidades.then((lista) {
        _sublocalidadeSelecionada = lista.firstWhere((sublocalidade) =>
            sublocalidade.id == atividadeSublocalidade.idSublocalidade);
      });
      _professores.then((lista) {
        _professorSelecionado = lista.firstWhere(
            (professor) => professor.id == atividadeSublocalidade.idProfessor);
      });
      _feiras.then((lista) {
        _feiraSelecionada = lista
            .firstWhere((feira) => feira.id == atividadeSublocalidade.idFeira);
      });
      _status = atividadeSublocalidade.status;
      _tipo = atividadeSublocalidade.tipo;
      _opcaoSelecionada = 'Sublocalidade';
    } else {
      _controladorNome.clear();
      _controladorDescricao.clear();
      _controladorQuantidadeMonitores.clear();
      _controladorCapacidadeVisitantes.clear();
      _controladorDuracaoSecao.clear();
      _localidadeSelecionada = null;
      _sublocalidadeSelecionada = null;
      _professorSelecionado = null;
      _feiraSelecionada = null;
      _status = null;
      _tipo = null;
      _opcaoSelecionada = 'Selecione uma opção';
    }
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text((atividadeLocalidade == null &&
                      atividadeSublocalidade == null)
                  ? 'Criar atividade'
                  : 'Editar atividade'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _controladorNome,
                      decoration: const InputDecoration(labelText: 'Nome'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _controladorDescricao,
                      decoration: const InputDecoration(labelText: 'Descrição'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _controladorQuantidadeMonitores,
                      decoration: const InputDecoration(
                          labelText: 'Quantidade de monitores'),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
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
                            value: _feiraSelecionada,
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
                    FutureBuilder<List<Professor>>(
                      future: _professores,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Erro: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Text('Nenhuma professor encontrado');
                        } else {
                          final professores = snapshot.data!;
                          return DropdownButtonFormField<Professor>(
                            value: _professorSelecionado,
                            hint: const Text("Selecione um professor"),
                            items: professores.map((Professor professor) {
                              return DropdownMenuItem<Professor>(
                                value: professor,
                                child: Text(professor.nome),
                              );
                            }).toList(),
                            onChanged: (Professor? novoProfessor) {
                              setStateDialog(() {
                                _professorSelecionado = novoProfessor;
                              });
                            },
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _opcaoSelecionada,
                      items:
                          ['Selecione uma opção', 'Localidade', 'Sublocalidade']
                              .map((option) => DropdownMenuItem(
                                    value: option,
                                    child: Text(option),
                                  ))
                              .toList(),
                      onChanged: (atividadeLocalidade != null ||
                              atividadeSublocalidade != null)
                          ? null
                          : (value) {
                              setStateDialog(() {
                                _opcaoSelecionada = value!;
                              });
                            },
                      decoration: const InputDecoration(
                          labelText: 'Selecione o tipo de local que atividade'),
                    ),
                    const SizedBox(height: 10),
                    _construirFormularioDinamico(),
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
                      if (_opcaoSelecionada == 'Localidade') {
                        final novaAtividade = AtividadeLocalidade(
                          nome: _controladorNome.text,
                          descricao: _controladorDescricao.text,
                          quantidadeMonitores:
                              int.parse(_controladorQuantidadeMonitores.text),
                          idFeira: _feiraSelecionada!.id!,
                          idProfessor: _professorSelecionado!.id!,
                          idLocalidade: _localidadeSelecionada!.id!,
                        );
                        if (atividadeLocalidade != null) {
                          await _atividadeLocalidadeService.updateAtividade(
                              atividadeLocalidade.id!, novaAtividade);
                        } else {
                          await _atividadeLocalidadeService
                              .createAtividade(novaAtividade);
                        }
                      } else {
                        final novaAtividade = AtividadeSublocalidade(
                          nome: _controladorNome.text,
                          descricao: _controladorDescricao.text,
                          quantidadeMonitores:
                              int.parse(_controladorQuantidadeMonitores.text),
                          idFeira: _feiraSelecionada!.id!,
                          idProfessor: _professorSelecionado!.id!,
                          idSublocalidade: _sublocalidadeSelecionada!.id!,
                          duracaoSecao:
                              int.parse(_controladorDuracaoSecao.text),
                          capacidadeVisitantes:
                              int.parse(_controladorCapacidadeVisitantes.text),
                          status: _status!,
                          tipo: _tipo!,
                        );
                        if (atividadeSublocalidade != null) {
                          await _atividadeSublocalidadeService.updateAtividade(
                              atividadeSublocalidade.id!, novaAtividade);
                        } else {
                          await _atividadeSublocalidadeService
                              .createAtividade(novaAtividade);
                        }
                      }
                      Navigator.pop(context);
                      _atualizarAtividades();
                      _mostrarSnackBar(
                          'Atividade ${(atividadeLocalidade == null && atividadeSublocalidade == null) ? 'criada' : 'atualizada'} com sucesso!');
                    }
                  },
                  child: Text((atividadeLocalidade == null ||
                          atividadeSublocalidade == null)
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

  Widget _construirFormularioDinamico() {
    if (_opcaoSelecionada == 'Selecione uma opção') {
      return const Column();
    } else if (_opcaoSelecionada == 'Localidade') {
      return Column(
        children: [
          FutureBuilder<List<Localidade>>(
            future: _localidades,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('Nenhuma localidade encontrada');
              } else {
                final localidades = snapshot.data!;
                return DropdownButtonFormField<Localidade>(
                  value: _localidadeSelecionada,
                  hint: const Text("Selecione uma localidade"),
                  items: localidades.map((Localidade localidade) {
                    return DropdownMenuItem<Localidade>(
                      value: localidade,
                      child: Text(localidade.nome),
                    );
                  }).toList(),
                  onChanged: (Localidade? novaLocalidade) {
                    setState(() {
                      _localidadeSelecionada = novaLocalidade;
                    });
                  },
                );
              }
            },
          ),
        ],
      );
    } else if (_opcaoSelecionada == 'Sublocalidade') {
      return Column(
        children: [
          FutureBuilder<List<Sublocalidade>>(
            future: _sublocalidades,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('Nenhuma sublocalidade encontrada');
              } else {
                final sublocalidades = snapshot.data!;
                return DropdownButtonFormField<Sublocalidade>(
                  value: _sublocalidadeSelecionada,
                  hint: const Text("Selecione uma sublocalidade"),
                  items: sublocalidades.map((Sublocalidade sublocalidade) {
                    return DropdownMenuItem<Sublocalidade>(
                      value: sublocalidade,
                      child: Text(sublocalidade.nome),
                    );
                  }).toList(),
                  onChanged: (Sublocalidade? novaSublocalidade) {
                    setState(() {
                      _sublocalidadeSelecionada = novaSublocalidade;
                    });
                  },
                );
              }
            },
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _controladorDuracaoSecao,
            decoration: const InputDecoration(labelText: 'Duração da seção'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _controladorCapacidadeVisitantes,
            decoration:
                const InputDecoration(labelText: 'Capacidade de visitantes'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<Status>(
            value: _status,
            hint: const Text("Selecione o status da atividade"),
            items: Status.values.map((Status status) {
              return DropdownMenuItem<Status>(
                value: status,
                child: Text(status.descricao),
              );
            }).toList(),
            onChanged: (Status? novoStatus) {
              setState(() {
                _status = novoStatus;
              });
            },
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<Tipo>(
            value: _tipo,
            hint: const Text("Selecione o tipo da atividade"),
            items: Tipo.values.map((Tipo tipo) {
              return DropdownMenuItem<Tipo>(
                value: tipo,
                child: Text(tipo.descricao),
              );
            }).toList(),
            onChanged: (Tipo? novoTipo) {
              setState(() {
                _tipo = novoTipo;
              });
            },
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  Future<void> _deleteAtividade(
      {AtividadeLocalidade? atividadeLocalidade,
      AtividadeSublocalidade? atividadeSublocalidade}) async {
    if (atividadeSublocalidade == null && atividadeLocalidade == null) {
      return;
    }
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
            'Excluir ${(atividadeLocalidade != null) ? atividadeLocalidade.nome : '${atividadeSublocalidade?.nome}'}'),
        content: Text(
            'Você tem certeza que quer excluir a atividade ${(atividadeLocalidade != null) ? atividadeLocalidade.nome : '${atividadeSublocalidade?.nome}'}?'),
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
      if (atividadeLocalidade != null) {
        await _atividadeLocalidadeService
            .deleteAtividade(atividadeLocalidade.id!);
      } else {
        await _atividadeSublocalidadeService
            .deleteAtividade(atividadeSublocalidade!.id!);
      }
      _atualizarAtividades();
      _mostrarSnackBar('Atividade excluída com sucesso.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atividades'),
      ),
      body: RefreshIndicator(
        onRefresh: _atualizarAtividades,
        child: FutureBuilder<List<dynamic>>(
          future:
              Future.wait([_atividadesLocalidade, _atividadesSublocalidade]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final atividadesLocalidade =
                snapshot.data![0] as List<AtividadeLocalidade>;
            final atividadesSublocalidade =
                snapshot.data![1] as List<AtividadeSublocalidade>;

            return ListView(
              children: [
                ..._buildAtividadeList(atividadesLocalidade,
                    isLocalidade: true),
                ..._buildAtividadeList(atividadesSublocalidade,
                    isLocalidade: false),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarFormAtividades(),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomAppBarOrganizador(),
    );
  }

  List<Widget> _buildAtividadeList(List atividades,
      {required bool isLocalidade}) {
    return atividades.map((atividade) {
      return Dismissible(
        key: Key(atividade.id.toString()),
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 16),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        onDismissed: (_) => _deleteAtividade(
          atividadeLocalidade: isLocalidade ? atividade : null,
          atividadeSublocalidade: isLocalidade ? null : atividade,
        ),
        child: ListTile(
          title: Text(atividade.nome),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _mostrarFormAtividades(
                  atividadeLocalidade: isLocalidade ? atividade : null,
                  atividadeSublocalidade: isLocalidade ? null : atividade,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _deleteAtividade(
                  atividadeLocalidade: isLocalidade ? atividade : null,
                  atividadeSublocalidade: isLocalidade ? null : atividade,
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}
