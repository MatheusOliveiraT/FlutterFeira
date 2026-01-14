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
  String filtroTexto = '';

  int? filtroDuracao;
  int? filtroLocalidade;

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

  bool correspondeFiltros(Atividade atividade) {
    if (filtroTexto.isNotEmpty &&
        !atividade.nome.toLowerCase().contains(filtroTexto.toLowerCase())) {
      return false;
    }

    if (filtroDuracao != null &&
        atividade.duracaoSecao != filtroDuracao) {
      return false;
    }

    if (filtroLocalidade != null &&
        atividade.idLocalidade != filtroLocalidade) {
      return false;
    }

    return true;
  }

  void _inscreverAtividade(Atividade atividade) {
    setState(() {
      atividade.inscrito = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Inscrição feita em "${atividade.nome}" com sucesso!',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final atividadesOrdenadas = [...atividades];

    atividadesOrdenadas.sort((a, b) {
      final aValida = correspondeFiltros(a);
      final bValida = correspondeFiltros(b);

      if (aValida && !bValida) return -1;
      if (!aValida && bValida) return 1;
      return 0;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feira de Profissões'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                labelText: 'Pesquisar atividade',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() => filtroTexto = value);
              },
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: filtroDuracao,
                    decoration: const InputDecoration(
                      labelText: 'Duração',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: null, child: Text('Todas')),
                      DropdownMenuItem(value: 45, child: Text('45 min')),
                      DropdownMenuItem(value: 60, child: Text('60 min')),
                    ],
                    onChanged: (value) {
                      setState(() => filtroDuracao = value);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: filtroLocalidade,
                    decoration: const InputDecoration(
                      labelText: 'Localidade',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: null, child: Text('Todas')),
                      DropdownMenuItem(value: 1, child: Text('Localidade 1')),
                      DropdownMenuItem(value: 2, child: Text('Localidade 2')),
                    ],
                    onChanged: (value) {
                      setState(() => filtroLocalidade = value);
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    filtroTexto = '';
                    filtroDuracao = null;
                    filtroLocalidade = null;
                  });
                },
                icon: const Icon(Icons.clear),
                label: const Text('Limpar filtros'),
              ),
            ),

            const SizedBox(height: 10),

            ...atividadesOrdenadas.map((atividade) {
              final corresponde = correspondeFiltros(atividade);

              return CustomCardMonitor(
                titulo: atividade.nome,
                duracao: '${atividade.duracaoSecao} min',
                local:
                    'Localidade ${atividade.idLocalidade}'
                    '${atividade.idSublocalidade != null ? ' - Sub ${atividade.idSublocalidade}' : ''}',
                descricao: atividade.descricao,
                quantidadeMonitores: atividade.quantidadeMonitores,
                inscrito: atividade.inscrito,
                desativado: !corresponde,
                onInscrever: () => _inscreverAtividade(atividade),
              );
            }).toList(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBarMonitor(),
    );
  }
}
