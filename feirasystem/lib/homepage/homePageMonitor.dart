import 'package:feirasystem/assets/bottomAppBarMonitor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:feirasystem/assets/customCardMonitor.dart';

class HomePageMonitor extends StatefulWidget {
  const HomePageMonitor({super.key});

  @override
  State<HomePageMonitor> createState() => _HomePageMonitorState();
}

class _HomePageMonitorState extends State<HomePageMonitor> {
  String nome = '';

  final List<Map<String, dynamic>> atividades = [
    {
      'titulo': 'Show da Física',
      'hora': '13:00 - 14:00',
      'local': 'Bloco E - Anfiteatro',
      'turno': 'Tarde',
      'vagas': 4,
      'inscrito': false,
    },
    {
      'titulo': 'Degustação de Refrigerantes',
      'hora': '10:00 - 12:00',
      'local': 'Bloco C - Sala C103',
      'turno': 'Manhã',
      'vagas': 3,
      'inscrito': false,
    },
    {
      'titulo': 'Divertidamente Química',
      'hora': '19:00 - 21:00',
      'local': 'Bloco G - Sala G003',
      'turno': 'Noite',
      'vagas': 2,
      'inscrito': false,
    },
  ];

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

  void _inscreverAtividade(int index) {
    setState(() {
      atividades[index]['inscrito'] = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Inscrição feita em "${atividades[index]['titulo']}" com sucesso!',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feira de Profissões'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: ListTile(
                title: Text(
                  nome.isEmpty
                      ? 'Seja bem-vindo(a)'
                      : 'Seja bem-vindo(a) $nome',
                  textAlign: TextAlign.center,
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
            const SizedBox(height: 20),

            const Center(
              child: Text(
                'Atividades disponíveis',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...List.generate(atividades.length, (index) {
              final atividade = atividades[index];
              return CustomCardMonitor(
                titulo: atividade['titulo'],
                hora: atividade['hora'],
                local: atividade['local'],
                inscrito: atividade['inscrito'],
                vagas: atividade['vagas'],
                turno: atividade['turno'],
                onInscrever: () => _inscreverAtividade(index),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBarMonitor(),
    );
  }
}
