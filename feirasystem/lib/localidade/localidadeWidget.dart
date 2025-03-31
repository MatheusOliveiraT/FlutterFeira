import 'package:feirasystem/localidade/localidadeService.dart';
import 'package:feirasystem/localidade/localidadeModel.dart';
import 'package:flutter/material.dart';

class Localidades extends StatefulWidget {
  const Localidades({super.key});
  @override
  _LocalidadesState createState() => _LocalidadesState();
}

class _LocalidadesState extends State<Localidades> {
  final LocalidadeService _localidadeService = LocalidadeService();
  late Future<List<Localidade>> _localidades;

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
      _localidades = _localidadeService.getLocalidades();
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
            onPressed: () async {
              if (_validarForm()) {
                try {
                  final novaLocalidade = Localidade(
                    nome: _controladorNome.text,
                    descricao: _controladorDescricao.text,
                    quantidadeSalas:
                        int.parse(_controladorQuantidadeSalas.text),
                  );
                  if (localidade != null) {
                    await _localidadeService.updateLocalidade(
                        localidade.id!, novaLocalidade);
                  } else {
                    await _localidadeService.createLocalidade(novaLocalidade);
                  }
                  Navigator.pop(context);
                  _atualizarLocalidades();
                  _mostrarSnackBar(
                      '${localidade == null ? 'Localidade criada' : '${localidade.nome} atualizada'} com sucesso!');
                } catch (e) {
                  _mostrarSnackBar(e.toString());
                }
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
      await _localidadeService.deleteLocalidade(localidade.id!);
      _atualizarLocalidades();
      _mostrarSnackBar('Localidade excluída com sucesso.');
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
      appBar: AppBar(title: const Text('Localidades')),
      body: RefreshIndicator(
        onRefresh: _atualizarLocalidades,
        child: FutureBuilder<List<Localidade>>(
          future: _localidades,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final localidades = snapshot.data!;
            return ListView.builder(
              itemCount: localidades.length,
              itemBuilder: (context, index) {
                final localidade = localidades[index];
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
                        '${localidade.descricao}\nQuantidade de salas: ${localidade.quantidadeSalas}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () =>
                                _mostrarFormLocalidade(localidade: localidade)),
                        IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteLocalidade(localidade)),
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
        onPressed: () => _mostrarFormLocalidade(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
