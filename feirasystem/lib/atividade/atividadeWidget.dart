// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'atividadeModel.dart';

class Atividades extends StatefulWidget {
  const Atividades({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _AtividadesState createState() => _AtividadesState();
}

class _AtividadesState extends State<Atividades> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorSublocalidade =
      TextEditingController();
  final TextEditingController _controladorQuantidadeMonitores =
      TextEditingController();
  final TextEditingController _controladorTipo = TextEditingController();
  final TextEditingController _controladorDuracaoSecao =
      TextEditingController();
  final TextEditingController _controladorCapacidadeVisitantes =
      TextEditingController();
  final TextEditingController _controladorStatus = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Atividades'),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _controladorNome,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.yellow),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, preencha este campo';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    controller: _controladorSublocalidade,
                    decoration: InputDecoration(
                      labelText: 'Sublocalidade',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.yellow),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, preencha este campo';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    controller: _controladorQuantidadeMonitores,
                    decoration: InputDecoration(
                      labelText: 'Quantidade de Monitores',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.yellow),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, preencha este campo';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    controller: _controladorTipo,
                    decoration: InputDecoration(
                      labelText: 'Tipo',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.yellow),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, preencha este campo';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    controller: _controladorDuracaoSecao,
                    decoration: InputDecoration(
                      labelText: 'Duração da Seção',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.yellow),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, preencha este campo';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    controller: _controladorCapacidadeVisitantes,
                    decoration: InputDecoration(
                      labelText: 'Capacidade de Visitantes',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.yellow),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, preencha este campo';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    controller: _controladorStatus,
                    decoration: InputDecoration(
                      labelText: 'Status',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.yellow),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, preencha este campo';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ElevatedButton(
                    child: const Text('Cadastrar'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final String nome = _controladorNome.text;
                        final String localidade =
                            _controladorSublocalidade.text;
                        final int? quantidadeMonitores =
                            int.tryParse(_controladorQuantidadeMonitores.text);
                        final String tipo = _controladorTipo.text;
                        final String duracaoSecao =
                            _controladorDuracaoSecao.text;
                        final int? capacidadeVisitantes =
                            int.tryParse(_controladorCapacidadeVisitantes.text);
                        final String status = _controladorStatus.text;

                        final Atividade atividadeNovo = Atividade(
                            nome,
                            localidade,
                            quantidadeMonitores!,
                            tipo,
                            duracaoSecao,
                            capacidadeVisitantes!,
                            status);
                        // ignore: avoid_print
                        print(atividadeNovo);
                        final snackBar = SnackBar(
                          content: const Text('Atividade criada com sucesso!'),
                          duration:
                              const Duration(seconds: 2), // Duração da mensagem
                          action: SnackBarAction(
                            label: 'Desfazer',
                            onPressed: () {
                              // Ação ao clicar no botão do SnackBar
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
