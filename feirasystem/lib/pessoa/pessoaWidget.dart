import 'package:flutter/material.dart';

class Pessoas extends StatelessWidget {
  const Pessoas({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Usuário'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'usuario/organizador');
            },
            child: const Text('Organizador'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'usuario/monitor');
            },
            child: const Text('Monitor'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'usuario/login');
            },
            child: const Text('Entrar'),
          )
        ],
      )),
    );
  }
}
