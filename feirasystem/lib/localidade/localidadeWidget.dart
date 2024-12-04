// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'localidadeModel.dart';

class Localidades extends StatelessWidget {
  Localidades({super.key});

  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorQuantidadeSalas =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Localidades'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controladorNome,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: _controladorQuantidadeSalas,
                decoration:
                    const InputDecoration(labelText: 'Quantidade de Salas'),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                child: const Text('Cadastrar'),
                onPressed: () {
                  final String nome = _controladorNome.text;
                  final int? quantidadeSalas =
                      int.tryParse(_controladorQuantidadeSalas.text);

                  final Localidade localidadeNovo =
                      Localidade(nome, quantidadeSalas!);
                  // ignore: avoid_print
                  print(localidadeNovo);
                  final snackBar = SnackBar(
                    content: const Text('Localidade criada com sucesso!'),
                    duration: const Duration(seconds: 2), // Duração da mensagem
                    action: SnackBarAction(
                      label: 'Desfazer',
                      onPressed: () {
                        // Ação ao clicar no botão do SnackBar
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}