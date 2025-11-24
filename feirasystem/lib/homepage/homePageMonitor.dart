import 'package:feirasystem/assets/bottomAppBarMonitor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:feirasystem/assets/customCardMonitor.dart';
import 'package:feirasystem/atividade/atividadeModel.dart';
import 'package:feirasystem/assets/mockBuilder.dart';

class HomePageMonitor extends StatefulWidget {
  const HomePageMonitor({super.key});

  @override
  State<HomePageMonitor> createState() => _HomePageMonitorState();
}

class _HomePageMonitorState extends State<HomePageMonitor> {
  String nome = '';
  String filtro = "";
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
    atividades = MockBuilder.retrieveAtividades();
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
    final atividadesOrdenadas = [...atividades];

    atividadesOrdenadas.sort((a, b) {
      final aMatch = a.nome.toLowerCase().contains(filtro.toLowerCase());
      final bMatch = b.nome.toLowerCase().contains(filtro.toLowerCase());

      if (aMatch && !bMatch) return -1;
      if (!aMatch && bMatch) return 1;
      return 0;
    });

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

            const SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                labelText: "Pesquisar atividade",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() => filtro = value);
              },
            ),

            const SizedBox(height: 20),

            ...List.generate(atividadesOrdenadas.length, (index) {
              final atividade = atividadesOrdenadas[index];

              final corresponde = atividade.nome
                  .toLowerCase()
                  .contains(filtro.toLowerCase());

              return CustomCardMonitor(
                titulo: atividade.nome,
                duracao: "${atividade.duracaoSecao} min",
                local:
                    "Localidade ${atividade.idLocalidade}${atividade.idSublocalidade != null ? " - Sub ${atividade.idSublocalidade}" : ""}",
                descricao: atividade.descricao,
                quantidadeMonitores: atividade.quantidadeMonitores,
                inscrito: atividade.inscrito,
                desativado: !corresponde,
                onInscrever: () =>
                    _inscreverAtividade(atividades.indexOf(atividade)),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBarMonitor(),
    );
  }
}
