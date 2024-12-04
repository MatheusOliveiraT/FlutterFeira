// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../localidade/localidadeWidget.dart';
import '../sublocalidade/sublocalidadeWidget.dart';
import '../atividade/atividadeWidget.dart';

class Cadastro extends StatelessWidget {
  const Cadastro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Cadastro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Localidades()),
                );
              },
              child: const Text('Localidades'),
            ),
            const SizedBox(height: 20), // Espaçamento entre os botões
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Sublocalidades()),
                );
              },
              child: const Text('Sublocalidades'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Atividades()),
                );
              },
              child: const Text('Atividades'),
            ),
          ],
        ),
      ),
    );
  }
}
