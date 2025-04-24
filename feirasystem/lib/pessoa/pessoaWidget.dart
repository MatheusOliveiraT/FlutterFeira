import 'package:flutter/material.dart';

class Pessoas extends StatelessWidget {
  const Pessoas({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feira de Profissões'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 400,
              minWidth: 200,
            ),
            child: const Card(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                title: Text(
                  'Seja bem-vindo(a) ao sistema da Feira de Profissões! Não possui uma conta ainda? Cadastre-se agora!',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'usuario/monitor');
            },
            child: const Text('Cadastre-se como monitor'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'usuario/organizador');
            },
            child: const Text('Cadastre-se como organizador'), // questionável
          ),
          const SizedBox(height: 64),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 400,
              minWidth: 200,
            ),
            child: const Card(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: ListTile(
                  title: Text(
                    'Já possui cadastro? Entre agora!',
                    textAlign: TextAlign.center,
                  ),
                )),
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
