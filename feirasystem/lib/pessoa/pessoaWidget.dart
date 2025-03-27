import 'package:flutter/material.dart';

class Pessoas extends StatelessWidget{
  const Pessoas({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Usuário'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'usuario/organizador');
              },
               child: const Text('Organizador'),
               ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'usuario/monitor');
              },
              child: const Text('Monitor'),
              )
          ],
        )
      ),
    );
  }
}