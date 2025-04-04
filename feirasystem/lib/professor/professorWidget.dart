import 'package:feirasystem/professor/professorModel.dart';
import 'package:feirasystem/professor/professorService.dart';
import 'package:feirasystem/departamento/departamentoModel.dart';
import 'package:feirasystem/departamento/departamentoService.dart';
import 'package:flutter/material.dart';

class Professores extends StatefulWidget {
  const Professores({super.key});
  @override
  _ProfessoresState createState() => _ProfessoresState();
}

class _ProfessoresState extends State<Professores> {
  final ProfessorService _professorService = ProfessorService();
  final DepartamentoService _departamentoService = DepartamentoService();
  late Future<List<Professor>> _professores;
  late Future<List<Departamento>> _departamentos;

  final TextEditingController _controladorNome = TextEditingController();
  Departamento? _departamentoSelecionado;

  @override
  void initState() {
    super.initState();
    _atualizarProfessores();
    _atualizarDepartamentos();
  }

  @override
  void dispose() {
    _controladorNome.dispose();
    super.dispose();
  }

  Future<void> _atualizarProfessores() async {
    setState(() {
      _professores = _professorService.getProfessores();
    });
  }

  Future<void> _atualizarDepartamentos() async {
    setState(() {
      _departamentos = _departamentoService.getDepartamentos();
    });
  }

  bool _validarForm() {
    if (_controladorNome.text.trim().isEmpty ||
        _departamentoSelecionado == null) {
      _mostrarSnackBar('Preencha todos os campos obrigatórios!');
      return false;
    }
    return true;
  }

  void _mostrarFormProfessor({Professor? professor}) async {
    if (professor != null) {
      _controladorNome.text = professor.nome;
      _departamentos.then((lista) {
        _departamentoSelecionado = lista.firstWhere(
            (departamento) => departamento.id == professor.idDepartamento);
      });
    } else {
      _controladorNome.clear();
      _departamentoSelecionado = null;
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(professor == null
              ? 'Criar Professor'
              : 'Editar ${professor.nome}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _controladorNome,
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                const SizedBox(height: 10),
                FutureBuilder<List<Departamento>>(
                  future: _departamentos,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Erro: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('Nenhum departamento encontrado.');
                    } else {
                      final departamentos = snapshot.data!;
                      return DropdownButtonFormField<Departamento>(
                        value: _departamentoSelecionado,
                        hint: const Text("Selecione um departamento"),
                        items: departamentos.map((Departamento departamento) {
                          return DropdownMenuItem<Departamento>(
                            value: departamento,
                            child: Text(departamento.nome),
                          );
                        }).toList(),
                        onChanged: (Departamento? novoDepartamento) {
                          setState(() {
                            _departamentoSelecionado = novoDepartamento;
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
                    final novoProfessor = Professor(
                      nome: _controladorNome.text,
                      idDepartamento: _departamentoSelecionado!.id!,
                    );
                    if (professor != null) {
                      await _professorService.updateProfessor(
                          professor.id!, novoProfessor);
                    } else {
                      await _professorService.createProfessor(novoProfessor);
                    }
                    Navigator.pop(context);
                    _mostrarSnackBar(
                        '${professor == null ? 'Professor criado' : '${professor.nome} atualizado(a)'} com sucesso!');
                    _atualizarProfessores();
                  } catch (e) {
                    _mostrarSnackBar(e.toString());
                  }
                }
              },
              child: Text(professor == null ? 'Criar' : 'Atualizar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteProfessor(Professor professor) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Excluir ${professor.nome}'),
        content: Text('Tem certeza que deseja excluir ${professor.nome}?'),
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
      await _professorService.deleteProfessor(professor.id!);
      _atualizarProfessores();
      _mostrarSnackBar('Professor excluído com sucesso.');
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
      appBar: AppBar(title: const Text('Professores')),
      body: RefreshIndicator(
        onRefresh: _atualizarProfessores,
        child: FutureBuilder<List<dynamic>>(
          future: Future.wait([_professores, _departamentos]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Nenhum professor encontrado.'));
            }
            final professores = snapshot.data![0];
            final departamentos = snapshot.data![1];
            return ListView.builder(
              itemCount: professores.length,
              itemBuilder: (context, index) {
                final professor = professores[index];
                return Dismissible(
                  key: Key(professor.id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) => _deleteProfessor(professor),
                  child: ListTile(
                    title: Text(professor.nome),
                    subtitle: Text(
                        'Departamento: ${departamentos.firstWhere((departamento) => departamento.id == professor.idDepartamento).nome}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () =>
                              _mostrarFormProfessor(professor: professor),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteProfessor(professor),
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
        onPressed: () => _mostrarFormProfessor(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
