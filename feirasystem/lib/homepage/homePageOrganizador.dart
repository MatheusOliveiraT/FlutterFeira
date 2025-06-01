import 'package:feirasystem/assets/bottomAppBarOrganizador.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageOrganizador extends StatefulWidget {
  const HomePageOrganizador({super.key});

  @override
  State<HomePageOrganizador> createState() => _HomePageOrganizadorState();
}

class _HomePageOrganizadorState extends State<HomePageOrganizador> {
  String nome = '';

  @override
  void initState() {
    super.initState();
    _loadNome();
  }

  Future<void> _loadNome() async {
    final prefs = await SharedPreferences.getInstance();
    final nomeArmazenado = prefs.getString('nome') ?? '';
    setState(() {
      nome = nomeArmazenado;
    });
  }

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
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                title: Text(
                  nome.isEmpty
                      ? 'Seja bem-vindo(a)'
                      : 'Seja bem-vindo(a) $nome',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      )),
      bottomNavigationBar: const BottomAppBarOrganizador(),
    );
  }
}
