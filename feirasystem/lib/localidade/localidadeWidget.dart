// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'localidadeModel.dart';

class Localidades extends StatefulWidget {
  const Localidades({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _LocalidadesState createState() => _LocalidadesState();
}

class _LocalidadesState extends State<Localidades> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorQuantidadeSalas =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Localidades'),
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
                  controller: _controladorQuantidadeSalas,
                  decoration: InputDecoration(
                    labelText: 'Quantidade de Salas',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.yellow),
                    ),
                  ),
                  keyboardType: TextInputType.number,
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
                      final int? quantidadeSalas =
                          int.tryParse(_controladorQuantidadeSalas.text);

                      final Localidade localidadeNovo =
                          Localidade(nome, quantidadeSalas!);
                      // ignore: avoid_print
                      print(localidadeNovo);
                      final snackBar = SnackBar(
                        content: const Text('Localidade criada com sucesso!'),
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
