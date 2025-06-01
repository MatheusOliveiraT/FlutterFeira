import 'package:feirasystem/assets/bottomAppBarOrganizador.dart';
import 'package:flutter/material.dart';

class Cadastro extends StatelessWidget {
  const Cadastro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastros'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'cadastro/feira');
              },
              child: const Text('Feiras'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'cadastro/agendamentofeira');
              },
              child: const Text('Agendamento de feira'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'cadastro/departamento');
              },
              child: const Text('Departamentos'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'cadastro/professor');
              },
              child: const Text('Professores'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'cadastro/localidade');
              },
              child: const Text('Localidades'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'cadastro/sublocalidade');
              },
              child: const Text('Sublocalidades'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'cadastro/atividade');
              },
              child: const Text('Atividades'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'usuario/organizador');
              },
              child: const Text('Organizador'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBarOrganizador(),
    );
  }
}
