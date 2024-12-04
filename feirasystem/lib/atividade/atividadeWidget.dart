// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'atividadeModel.dart';

class Atividades extends StatelessWidget {
  Atividades({super.key});

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Atividades'),
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
                controller: _controladorSublocalidade,
                decoration: const InputDecoration(labelText: 'Sublocalidade'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: _controladorQuantidadeMonitores,
                decoration:
                    const InputDecoration(labelText: 'Quantidade de Monitores'),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: _controladorTipo,
                decoration: const InputDecoration(labelText: 'Tipo'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: _controladorDuracaoSecao,
                decoration:
                    const InputDecoration(labelText: 'Duração da Seção'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: _controladorCapacidadeVisitantes,
                decoration: const InputDecoration(
                    labelText: 'Capacidade de Visitantes'),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: _controladorStatus,
                decoration: const InputDecoration(labelText: 'Status'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                child: const Text('Cadastrar'),
                onPressed: () {
                  final String nome = _controladorNome.text;
                  final String localidade = _controladorSublocalidade.text;
                  final int? quantidadeMonitores =
                      int.tryParse(_controladorQuantidadeMonitores.text);
                  final String tipo = _controladorTipo.text;
                  final String duracaoSecao = _controladorDuracaoSecao.text;
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
