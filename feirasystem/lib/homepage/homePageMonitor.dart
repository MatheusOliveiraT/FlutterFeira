import 'package:feirasystem/assets/bottomAppBarMonitor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageMonitor extends StatefulWidget {
  const HomePageMonitor({super.key});

  @override
  State<HomePageMonitor> createState() => _HomePageMonitorState();
}

class _HomePageMonitorState extends State<HomePageMonitor> {
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
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'monitor/atividades');
              },
              child: const Text('Minhas atividades'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBarMonitor(),
    );
  }
}
