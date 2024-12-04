import 'sublocalidadeModel.dart';
import 'package:flutter/material.dart';

class Sublocalidades extends StatelessWidget {
  Sublocalidades({super.key});

  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorLocalidade = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Sublocalidades'),
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
                controller: _controladorLocalidade,
                decoration: const InputDecoration(labelText: 'Localidade'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                child: const Text('Cadastrar'),
                onPressed: () {
                  final String nome = _controladorNome.text;
                  final String localidade = _controladorLocalidade.text;

                  final Sublocalidade subLocalidadeNovo =
                      Sublocalidade(nome, localidade);
                  // ignore: avoid_print
                  print(subLocalidadeNovo);
                  final snackBar = SnackBar(
                    content: const Text('Sublocalidade criada com sucesso!'),
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
