import 'package:flutter/material.dart';
import 'feiraModel.dart';

class Feiras extends StatefulWidget {
  const Feiras({super.key});
  @override
  _FeirasState createState() => _FeirasState();
}

class _FeirasState extends State<Feiras> {
  final List<Feira> _feiras = [
    Feira(0, 'Feira das Profissões 2025'),
    Feira(1, 'Feira das Profissões 2026'),
  ];

  final TextEditingController _controladorNome = TextEditingController();

  @override
  void initState() {
    super.initState();
    _atualizarFeiras();
  }

  @override
  void dispose() {
    _controladorNome.dispose();
    super.dispose();
  }

  bool _validarForm() {
    String nome = _controladorNome.text.trim();
    if (nome.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Preencha todos os campos obrigatórios!'),
            duration: Duration(seconds: 1)),
      );
      return false;
    }
    return true;
  }

  Future<void> _atualizarFeiras() async {
    setState(() {
      // RETRIEVE
    });
  }

  void _mostrarFormFeira({Feira? feira}) {
    if (feira != null) {
      _controladorNome.text = feira.nome;
    } else {
      _controladorNome.clear();
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(feira == null ? 'Criar feira' : 'Editar ${feira.nome}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _controladorNome,
                decoration: const InputDecoration(labelText: 'Nome'),
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
                if (feira != null) {
                  // UPDATE
                } else {
                  // CREATE
                }
                Navigator.pop(context);
                final snackBar = SnackBar(
                  content: Text(
                      '${feira == null ? 'Feira criada' : '${feira.nome} atualizado(a)'} com sucesso!'),
                  duration: const Duration(seconds: 2), // Duração da mensagem
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: Text(feira == null ? 'Criar' : 'Atualizar'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteFeira(Feira feira) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Excluir ${feira.nome}'),
        content:
            Text('Você tem certeza que quer excluir a feira ${feira.nome}?'),
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
            content: Text('Feira excluída com sucesso.'),
            duration: Duration(seconds: 2)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feiras'),
      ),
      body: RefreshIndicator(
        onRefresh: _atualizarFeiras,
        child: ListView.builder(
          itemCount: _feiras.length,
          itemBuilder: (context, index) {
            final feira = _feiras[index];
            return Dismissible(
              key: Key(feira.id.toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 16),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (_) => _deleteFeira(feira),
              child: ListTile(
                title: Text(feira.nome),
                trailing: Row(
                  mainAxisSize:
                      MainAxisSize.min, // Makes the Row take minimum space
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _mostrarFormFeira(feira: feira),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteFeira(feira),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarFormFeira(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
