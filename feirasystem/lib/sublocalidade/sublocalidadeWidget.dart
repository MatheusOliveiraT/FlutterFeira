import 'package:feirasystem/localidade/localidadeModel.dart';
import 'package:feirasystem/localidade/localidadeService.dart';
import 'package:feirasystem/sublocalidade/sublocalidadeModel.dart';
import 'package:feirasystem/sublocalidade/sublocalidadeService.dart';
import 'package:flutter/material.dart';

class Sublocalidades extends StatefulWidget {
  const Sublocalidades({super.key});
  @override
  _SublocalidadesState createState() => _SublocalidadesState();
}

class _SublocalidadesState extends State<Sublocalidades> {
  final LocalidadeService _localidadeService = LocalidadeService();
  final SublocalidadeService _sublocalidadeService = SublocalidadeService();
  late Future<List<Localidade>> _localidades;
  late Future<List<Sublocalidade>> _sublocalidades;

  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorDescricao = TextEditingController();
  Localidade? _localidadeSelecionada;

  @override
  void initState() {
    super.initState();
    _atualizarLocalidades();
    _atualizarSublocalidades();
  }

  @override
  void dispose() {
    _controladorNome.dispose();
    _controladorDescricao.dispose();
    super.dispose();
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

  bool _validarForm() {
    String nome = _controladorNome.text.trim();
    String descricao = _controladorDescricao.text.trim();
    if (nome.isEmpty || descricao.isEmpty || _localidadeSelecionada == null) {
      _mostrarSnackBar('Preencha todos os campos obrigatórios!');
      return false;
    }
    return true;
  }

  void _mostrarFormSublocalidade({Sublocalidade? sublocalidade}) async {
    if (sublocalidade != null) {
      _controladorNome.text = sublocalidade.nome;
      _controladorDescricao.text = sublocalidade.descricao;
      _localidades.then((lista) {
        _localidadeSelecionada = lista.firstWhere(
            (localidade) => localidade.id == sublocalidade.idLocalidade);
      });
    } else {
      _controladorNome.clear();
      _controladorDescricao.clear();
      _localidadeSelecionada = null;
    }
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text(sublocalidade == null
                  ? 'Criar sublocalidade'
                  : 'Editar ${sublocalidade.nome}'),
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
                    FutureBuilder<List<Localidade>>(
                      future: _localidades,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Erro: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
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
                              setStateDialog(() {
                                _localidadeSelecionada = novaLocalidade;
                              });
                            },
                          );
                        }
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
                      try {
                        final novaSublocalidade = Sublocalidade(
                          nome: _controladorNome.text,
                          descricao: _controladorDescricao.text,
                          idLocalidade: _localidadeSelecionada!.id!,
                        );
                        if (sublocalidade != null) {
                          await _sublocalidadeService.updateSublocalidade(
                              sublocalidade.id!, novaSublocalidade);
                        } else {
                          await _sublocalidadeService
                              .createSublocalidade(novaSublocalidade);
                        }
                        Navigator.pop(context);
                        _atualizarSublocalidades();
                        _mostrarSnackBar(
                            '${sublocalidade == null ? 'Sublocalidade criada' : '${sublocalidade.nome} atualizado(a)'} com sucesso!');
                      } catch (e) {
                        _mostrarSnackBar(e.toString());
                      }
                    }
                  },
                  child: Text(sublocalidade == null ? 'Criar' : 'Atualizar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _deleteSublocalidade(Sublocalidade sublocalidade) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Excluir ${sublocalidade.nome}'),
        content: Text(
            'Você tem certeza que quer excluir a sublocalidade ${sublocalidade.nome}?'),
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
      await _sublocalidadeService.deleteSublocalidade(sublocalidade.id!);
      _atualizarSublocalidades();
      _mostrarSnackBar('Sublocalidade excluída com sucesso.');
    }
  }

  void _mostrarSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sublocalidades'),
      ),
      body: RefreshIndicator(
        onRefresh: _atualizarSublocalidades,
        child: FutureBuilder<List<dynamic>>(
          future: Future.wait([_sublocalidades, _localidades]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                  child: Text('Nenhuma sublocalidade encontrada.'));
            }

            final sublocalidades = snapshot.data![0];
            final localidades = snapshot.data![1];

            return ListView.builder(
              itemCount: sublocalidades.length,
              itemBuilder: (context, index) {
                final sublocalidade = sublocalidades[index];
                return Dismissible(
                  key: Key(sublocalidade.id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) => _deleteSublocalidade(sublocalidade),
                  child: ListTile(
                    title: Text(sublocalidade.nome),
                    subtitle: Text(
                      '${sublocalidade.descricao}\nLocalidade: ${localidades.firstWhere((localidade) => localidade.id == sublocalidade.idLocalidade).nome}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _mostrarFormSublocalidade(
                              sublocalidade: sublocalidade),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteSublocalidade(sublocalidade),
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
        onPressed: () => _mostrarFormSublocalidade(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
