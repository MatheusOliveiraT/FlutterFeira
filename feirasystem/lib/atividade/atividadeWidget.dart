import 'package:feirasystem/assets/bottomAppBarOrganizador.dart';
import 'package:feirasystem/assets/customSnackBar.dart';
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
  final AtividadeService _atividadeService = AtividadeService();
  final FeiraService _feiraService = FeiraService();
  final ProfessorService _professorService = ProfessorService();
  final LocalidadeService _localidadeService = LocalidadeService();
  final SublocalidadeService _sublocalidadeService = SublocalidadeService();
  late Future<List<Atividade>> _atividades;
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
      _atividades = _atividadeService.getAtividades();
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
      showCustomSnackBar(context, 'Preencha todos os campos obrigatórios!',
          tipo: 'erro');
      return false;
    }
    if (int.tryParse(quantidadeMonitores) == null) {
      showCustomSnackBar(
          context, 'Quantidade de monitores precisa ser um número inteiro.');
      return false;
    }
    if (_opcaoSelecionada == 'Localidade') {
      if (_localidadeSelecionada == null) {
        showCustomSnackBar(context, 'Preencha todos os campos obrigatórios!',
            tipo: 'erro');
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
        showCustomSnackBar(context, 'Preencha todos os campos obrigatórios!',
            tipo: 'erro');
        return false;
      } else if (int.tryParse(duracaoSecao) == null ||
          int.tryParse(capacidadeVisitantes) == null) {
        showCustomSnackBar(context,
            'Duração da seção e capacidade de visitantes precisam ser um número inteiro.');
        return false;
      }
    } else {
      showCustomSnackBar(context, 'Preencha todos os campos obrigatórios!',
          tipo: 'erro');
      return false;
    }
    return true;
  }

  Future<void> _mostrarFormAtividades({Atividade? atividade}) async {
    if (atividade != null) {
      _controladorNome.text = atividade.nome;
      _controladorDescricao.text = atividade.descricao;
      _controladorQuantidadeMonitores.text =
          atividade.quantidadeMonitores.toString();
      _professores.then((lista) {
        _professorSelecionado = lista
            .firstWhere((professor) => professor.id == atividade.idProfessor);
      });
      _feiras.then((lista) {
        _feiraSelecionada =
            lista.firstWhere((feira) => feira.id == atividade.idFeira);
      });
      if (atividade.tipoAtividade == TipoAtividade.LOCALIDADE) {
        _localidades.then((lista) {
          _localidadeSelecionada = lista.firstWhere(
              (localidade) => localidade.id == atividade.idLocalidade);
        });
        _controladorCapacidadeVisitantes.clear();
        _controladorDuracaoSecao.clear();
        _sublocalidadeSelecionada = null;
        _status = null;
        _tipo = null;
        _opcaoSelecionada = 'Localidade';
      } else {
        _controladorCapacidadeVisitantes.text =
            atividade.capacidadeVisitantes.toString();
        _controladorDuracaoSecao.text = atividade.duracaoSecao.toString();
        _localidadeSelecionada = null;
        _sublocalidades.then((lista) {
          _sublocalidadeSelecionada = lista.firstWhere(
              (sublocalidade) => sublocalidade.id == atividade.idSublocalidade);
        });
        _status = atividade.status;
        _tipo = atividade.tipo;
        _opcaoSelecionada = 'Sublocalidade';
      }
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
              title: Text(
                  (atividade == null) ? 'Criar atividade' : 'Editar atividade'),
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
                            initialValue: _professorSelecionado,
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
                      initialValue: _opcaoSelecionada,
                      items:
                          ['Selecione uma opção', 'Localidade', 'Sublocalidade']
                              .map((option) => DropdownMenuItem(
                                    value: option,
                                    child: Text(option),
                                  ))
                              .toList(),
                      onChanged: (atividade != null)
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
                        final novaAtividade = Atividade(
                          nome: _controladorNome.text,
                          descricao: _controladorDescricao.text,
                          quantidadeMonitores:
                              int.parse(_controladorQuantidadeMonitores.text),
                          idFeira: _feiraSelecionada!.id!,
                          idProfessor: _professorSelecionado!.id!,
                          idLocalidade: _localidadeSelecionada!.id!,
                          tipoAtividade: TipoAtividade.LOCALIDADE,
                        );
                        if (atividade != null) {
                          await _atividadeService.updateAtividade(
                              atividade.id!, novaAtividade);
                        } else {
                          await _atividadeService
                              .createAtividade(novaAtividade);
                        }
                      } else {
                        final novaAtividade = Atividade(
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
                          tipoAtividade: TipoAtividade.SUBLOCALIDADE,
                        );
                        if (atividade != null) {
                          await _atividadeService.updateAtividade(
                              atividade.id!, novaAtividade);
                        } else {
                          await _atividadeService
                              .createAtividade(novaAtividade);
                        }
                      }
                      Navigator.pop(context);
                      _atualizarAtividades();
                      showCustomSnackBar(context,
                          'Atividade ${(atividade == null) ? 'criada' : 'atualizada'} com sucesso!',
                          tipo: 'sucesso');
                    }
                  },
                  child: Text((atividade == null) ? 'Criar' : 'Atualizar'),
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
                  initialValue: _localidadeSelecionada,
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
                  initialValue: _sublocalidadeSelecionada,
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
            initialValue: _status,
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
            initialValue: _tipo,
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

  Future<void> _deleteAtividade(Atividade atividade) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Excluir ${atividade.nome}'),
        content: Text(
            'Você tem certeza que quer excluir a atividade ${atividade.nome}?'),
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
      await _atividadeService.deleteAtividade(atividade.id!);
      _atualizarAtividades();
      showCustomSnackBar(context, 'Atividade excluída com sucesso.',
          tipo: 'sucesso');
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
          future: Future.wait([_atividades]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final atividades = snapshot.data![0] as List<Atividade>;

            return ListView(
              children: [
                ..._buildAtividadeList(atividades),
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

  List<Widget> _buildAtividadeList(List atividades) {
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
          atividade,
        ),
        child: ListTile(
          title: Text(atividade.nome),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _mostrarFormAtividades(
                  atividade: atividade,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _deleteAtividade(
                  atividade,
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}
