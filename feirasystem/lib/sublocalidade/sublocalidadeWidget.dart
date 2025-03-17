// ignore_for_file: file_names

import 'sublocalidadeModel.dart';
import 'package:flutter/material.dart';

class Sublocalidades extends StatefulWidget {
  const Sublocalidades({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _SublocalidadesState createState() => _SublocalidadesState();
}

class _SublocalidadesState extends State<Sublocalidades> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorLocalidade = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sublocalidades'),
      ),
      body: Padding(
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
                  controller: _controladorLocalidade,
                  decoration: InputDecoration(
                    labelText: 'Localidade',
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
                      final String localidade = _controladorLocalidade.text;

                      final Sublocalidade subLocalidadeNovo =
                          Sublocalidade(nome, localidade);
                      // ignore: avoid_print
                      print(subLocalidadeNovo);
                      final snackBar = SnackBar(
                        content:
                            const Text('Sublocalidade criada com sucesso!'),
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
        ),
      ),
    );
  }
}
