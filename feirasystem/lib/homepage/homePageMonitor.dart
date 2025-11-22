import 'package:feirasystem/assets/bottomAppBarMonitor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:feirasystem/assets/customCardMonitor.dart';
import 'package:feirasystem/atividade/atividadeModel.dart';
import 'package:feirasystem/assets/mockbuilder.dart';

class HomePageMonitor extends StatefulWidget {
  const HomePageMonitor({super.key});

  @override
  State<HomePageMonitor> createState() => _HomePageMonitorState();
}

class _HomePageMonitorState extends State<HomePageMonitor> {
  String nome = '';
  List<Atividade> atividades = [];

  @override
  void initState() {
    super.initState();
    _loadNome();
    _loadAtividadesMock();
  }

  Future<void> _loadNome() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nome = prefs.getString('nome') ?? '';
    });
  }

  void _loadAtividadesMock() {
    atividades = [
      MockBuilder.retrieveAtividadeSublocalidade(),
    ];

    setState(() {});
  }

  void _inscreverAtividade(int index) {
    setState(() {
      atividades[index].inscrito = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Inscrição feita em "${atividades[index].nome}" com sucesso!',
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
              child: ListTile(
                title: Text(
                  nome.isEmpty ? 'Seja bem-vindo(a)' : 'Seja bem-vindo(a) $nome',
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            ...List.generate(atividades.length, (index) {
              final a = atividades[index];

              return CustomCardMonitor(
                titulo: a.nome,
                duracao: "${a.duracaoSecao} min",
                local: "Localidade ${a.idLocalidade} - Sub ${a.idSublocalidade}",
                descricao: a.descricao,
                quantidadeMonitores: a.quantidadeMonitores,
                inscrito: a.inscrito,
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
