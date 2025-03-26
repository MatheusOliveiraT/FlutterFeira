import 'package:flutter/material.dart';
import 'localidadeModel.dart';

class Localidades extends StatefulWidget {
  const Localidades({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _LocalidadesState createState() => _LocalidadesState();
}

class _LocalidadesState extends State<Localidades> {
  final List<Localidade> _localidades = [
    Localidade(
        id: 0,
        nome: 'Bloco A',
        quantidadeSalas: 15,
        descricao: 'Bloco A da UTFPR'),
    Localidade(
        id: 1,
        nome: 'Bloco B',
        quantidadeSalas: 4,
        descricao: 'Bloco B da UTFPR')
  ];

  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorQuantidadeSalas =
      TextEditingController();
  final TextEditingController _controladorDescricao = TextEditingController();

  @override
  void initState() {
    super.initState();
    _atualizarLocalidades();
  }

  @override
  void dispose() {
    _controladorNome.dispose();
    _controladorDescricao.dispose();
    _controladorQuantidadeSalas.dispose();
    super.dispose();
  }

  bool _validarForm() {
    String nome = _controladorNome.text.trim();
    String quantidadeSalas = _controladorQuantidadeSalas.text.trim();
    String descricao = _controladorDescricao.text.trim();
    if (nome.isEmpty || quantidadeSalas.isEmpty || descricao.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Preencha todos os campos obrigatórios!'),
            duration: Duration(seconds: 1)),
      );
      return false;
    } else if (int.tryParse(quantidadeSalas) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Quantidade de salas precisa ser um número!'),
            duration: Duration(seconds: 1)),
      );
      return false;
    }
    return true;
  }

  Future<void> _atualizarLocalidades() async {
    setState(() {
      // RETRIEVE
    });
  }

  void _mostrarFormLocalidade({Localidade? localidade}) {
    if (localidade != null) {
      _controladorNome.text = localidade.nome;
      _controladorQuantidadeSalas.text = localidade.quantidadeSalas.toString();
      _controladorDescricao.text = localidade.descricao;
    } else {
      _controladorNome.clear();
      _controladorQuantidadeSalas.clear();
      _controladorDescricao.clear();
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localidade == null
            ? 'Criar localidade'
            : 'Editar ${localidade.nome}'),
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
                controller: _controladorQuantidadeSalas,
                decoration:
                    const InputDecoration(labelText: 'Quantidade de salas'),
                keyboardType: TextInputType.number,
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
                if (localidade != null) {
                  // UPDATE
                } else {
                  // CREATE
                }
                Navigator.pop(context);
                final snackBar = SnackBar(
                  content: Text(
                      '${localidade == null ? 'Localidade criada' : '${localidade.nome} atualizado(a)'} com sucesso!'),
                  duration: const Duration(seconds: 2), // Duração da mensagem
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: Text(localidade == null ? 'Criar' : 'Atualizar'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteLocalidade(Localidade localidade) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Excluir ${localidade.nome}'),
        content: Text(
            'Você tem certeza que quer excluir a localidade ${localidade.nome}?'),
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Localidade excluída com sucesso.'),
            duration: Duration(seconds: 2)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Localidades'),
      ),
      body: RefreshIndicator(
        onRefresh: _atualizarLocalidades,
        child: ListView.builder(
          itemCount: _localidades.length,
          itemBuilder: (context, index) {
            final localidade = _localidades[index];
            return Dismissible(
              key: Key(localidade.id.toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 16),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (_) => _deleteLocalidade(localidade),
              child: ListTile(
                title: Text(localidade.nome),
                subtitle: Text(
                  '${localidade.descricao}\nQuantidade de salas: ${localidade.quantidadeSalas.toString()}',
                ),
                trailing: Row(
                  mainAxisSize:
                      MainAxisSize.min, // Makes the Row take minimum space
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () =>
                          _mostrarFormLocalidade(localidade: localidade),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteLocalidade(localidade),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarFormLocalidade(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
