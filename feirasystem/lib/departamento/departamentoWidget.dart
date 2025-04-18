import 'package:feirasystem/assets/bottomAppBarOrganizador.dart';
import 'package:flutter/material.dart';
import 'package:feirasystem/departamento/departamentoModel.dart';
import 'package:feirasystem/departamento/departamentoService.dart';

class Departamentos extends StatefulWidget {
  const Departamentos({super.key});
  @override
  _DepartamentosState createState() => _DepartamentosState();
}

class _DepartamentosState extends State<Departamentos> {
  final DepartamentoService _departamentoService = DepartamentoService();
  late Future<List<Departamento>> _departamentos;

  final TextEditingController _controladorNome = TextEditingController();

  @override
  void initState() {
    super.initState();
    _atualizarDepartamentos();
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

  Future<void> _atualizarDepartamentos() async {
    setState(() {
      _departamentos = _departamentoService.getDepartamentos();
    });
  }

  void _mostrarFormDepartamento({Departamento? departamento}) {
    if (departamento != null) {
      _controladorNome.text = departamento.nome;
    } else {
      _controladorNome.clear();
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(departamento == null
            ? 'Criar departamento'
            : 'Editar ${departamento.nome}'),
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
            onPressed: () async {
              if (_validarForm()) {
                try {
                  final newDepartamento =
                      Departamento(nome: _controladorNome.text);
                  if (departamento != null) {
                    await _departamentoService.updateDepartamento(
                        departamento.id!, newDepartamento);
                  } else {
                    await _departamentoService
                        .createDepartamento(newDepartamento);
                  }
                  Navigator.pop(context);
                  _atualizarDepartamentos();
                  _mostrarSnackBar(
                      '${departamento == null ? 'Departamento criado' : '${departamento.nome} atualizado(a)'} com sucesso!');
                } catch (e) {
                  _mostrarSnackBar(e.toString());
                }
              }
            },
            child: Text(departamento == null ? 'Criar' : 'Atualizar'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteDepartamento(Departamento departamento) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Excluir ${departamento.nome}'),
        content: Text(
            'Você tem certeza que quer excluir o departamento ${departamento.nome}?'),
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
      await _departamentoService.deleteDepartamento(departamento.id!);
      _atualizarDepartamentos();
      _mostrarSnackBar('Departamento excluído com sucesso.');
    }
  }

  void _mostrarSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Departamentos'),
      ),
      body: RefreshIndicator(
        onRefresh: _atualizarDepartamentos,
        child: FutureBuilder<List<Departamento>>(
          future: _departamentos,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final departamentos = snapshot.data!;
            return ListView.builder(
                itemCount: departamentos.length,
                itemBuilder: (context, index) {
                  final departamento = departamentos[index];
                  return Dismissible(
                    key: Key(departamento.id.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 16),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (_) => _deleteDepartamento(departamento),
                    child: ListTile(
                      title: Text(departamento.nome),
                      trailing: Row(
                        mainAxisSize: MainAxisSize
                            .min, // Makes the Row take minimum space
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _mostrarFormDepartamento(
                                departamento: departamento),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteDepartamento(departamento),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarFormDepartamento(),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomAppBarOrganizador(),
    );
  }
}
