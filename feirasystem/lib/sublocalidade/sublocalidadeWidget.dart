// ignore_for_file: file_names

import 'package:feirasystem/localidade/localidadeModel.dart';
import 'sublocalidadeModel.dart';
import 'package:flutter/material.dart';

class Sublocalidades extends StatefulWidget {
  const Sublocalidades({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _SublocalidadesState createState() => _SublocalidadesState();
}

class _SublocalidadesState extends State<Sublocalidades> {
  final List<Localidade> _localidades = [
    Localidade(0, 'Bloco A', 15, 'Bloco A da UTFPR'),
    Localidade(1, 'Bloco B', 4, 'Bloco B da UTFPR')
  ];
  List<Sublocalidade> _sublocalidades = [];

  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorDescricao = TextEditingController();
  Localidade? _localidadeSelecionada;

  @override
  void initState() {
    super.initState();
    _atualizarSublocalidades();
    _sublocalidades = [
      Sublocalidade(
          0, 'Aquário', 'Aquário', _localidades.firstWhere((l) => l.id == 0)),
      Sublocalidade(1, 'B102', 'Andar superior',
          _localidades.firstWhere((l) => l.id == 1)),
      Sublocalidade(2, 'B103', 'Andar superior',
          _localidades.firstWhere((l) => l.id == 1)),
    ];
  }

  @override
  void dispose() {
    _controladorNome.dispose();
    _controladorDescricao.dispose();
    super.dispose();
  }

  Future<void> _atualizarSublocalidades() async {
    setState(() {
      // RETRIEVE
    });
  }

  bool _validarForm() {
    String nome = _controladorNome.text.trim();
    String descricao = _controladorDescricao.text.trim();
    if (nome.isEmpty || descricao.isEmpty || _localidadeSelecionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Preencha todos os campos obrigatórios!'),
            duration: Duration(seconds: 1)),
      );
      return false;
    }
    return true;
  }

  void _mostrarFormSublocalidade({Sublocalidade? sublocalidade}) {
    if (sublocalidade != null) {
      _controladorNome.text = sublocalidade.nome;
      _controladorDescricao.text = sublocalidade.descricao;
      _localidadeSelecionada = sublocalidade.localidade;
    } else {
      _controladorNome.clear();
      _controladorDescricao.clear();
      _localidadeSelecionada = null;
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
              TextField(
                controller: _controladorDescricao,
                decoration: const InputDecoration(labelText: 'Descrição'),
              ),
              DropdownButton<Localidade>(
                value: _localidadeSelecionada,
                hint: const Text("Selecione uma localidade"),
                items: _localidades.map((Localidade localidade) {
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
              )
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
                if (sublocalidade != null) {
                  // UPDATE
                } else {
                  // CREATE
                }
                Navigator.pop(context);
                final snackBar = SnackBar(
                  content: Text(
                      '${sublocalidade == null ? 'Sublocalidade criada' : '${sublocalidade.nome} atualizado(a)'} com sucesso!'),
                  duration: const Duration(seconds: 2), // Duração da mensagem
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: Text(sublocalidade == null ? 'Criar' : 'Atualizar'),
          ),
        ],
      ),
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
      // DELETE
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Sublocalidade excluída com sucesso.'),
            duration: Duration(seconds: 2)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sublocalidades'),
      ),
      body: RefreshIndicator(
        onRefresh: _atualizarSublocalidades,
        child: ListView.builder(
          itemCount: _sublocalidades.length,
          itemBuilder: (context, index) {
            final sublocalidade = _sublocalidades[index];
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
                  '${sublocalidade.descricao}\nLocalidade: ${sublocalidade.localidade.nome}',
                ),
                trailing: Row(
                  mainAxisSize:
                      MainAxisSize.min, // Makes the Row take minimum space
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarFormSublocalidade(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
