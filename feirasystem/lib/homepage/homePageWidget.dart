// ignore_for_file: file_names

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feira de profissões'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'perfil');
              },
              icon: const Icon(Icons.person_pin))
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'cadastro');
            },
            child: const Text('Cadastros'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'usuario');
            },
            child: const Text('Usuários'),
          ),
        ],
      )),
    );
  }
}
