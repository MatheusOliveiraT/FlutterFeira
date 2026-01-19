import 'package:feirasystem/assets/bottomAppBarMonitor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:feirasystem/assets/customCardMonitor.dart';
import 'package:feirasystem/atividade/atividadeModel.dart';
import 'package:feirasystem/atividade/atividadeService.dart';

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
  List<int> duracoesDisponiveis = [];
  List<int> localidadesDisponiveis = [];

  bool carregando = true;

  final AtividadeService _service = AtividadeService();

  @override
  void initState() {
    super.initState();
    _loadNome();
    _loadAtividadesBackend();
  }

  Future<void> _loadNome() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nome = prefs.getString('nome') ?? '';
    });
  }

  Future<void> _loadAtividadesBackend() async {
    try {
      final lista = await _service.getAtividades();

      final duracoes = lista
        .map((a) => a.duracaoSecao)
        .whereType<int>() 
        .toSet()
        .toList()
      ..sort();

      final localidades = lista
          .map((a) => a.idLocalidade)
          .whereType<int>()
          .toSet()
          .toList()
        ..sort();


      setState(() {
        atividades = lista;
        duracoesDisponiveis = duracoes;
        localidadesDisponiveis = localidades;
        carregando = false;
      });
    } catch (e, s) {
      debugPrint('Erro ao carregar atividades: $e');
      debugPrintStack(stackTrace: s);

      setState(() => carregando = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao carregar atividades')),
      );
    }
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
    if (carregando) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final atividadesOrdenadas = [...atividades]
      ..sort((a, b) {
        final aValida = correspondeFiltros(a);
        final bValida = correspondeFiltros(b);

        if (aValida && !bValida) return -1;
        if (!aValida && bValida) return 1;
        return 0;
      });

    return Scaffold(
      appBar: AppBar(title: const Text('Feira de Profissões')),
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
                  child: DropdownButtonFormField<int?>(
                    value: filtroDuracao,
                    decoration: const InputDecoration(
                      labelText: 'Duração',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem<int?>(
                        value: null,
                        child: Text('Todas'),
                      ),
                      ...duracoesDisponiveis.map(
                        (duracao) => DropdownMenuItem<int?>(
                          value: duracao,
                          child: Text('$duracao min'),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() => filtroDuracao = value);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<int?>(
                    value: filtroLocalidade,
                    decoration: const InputDecoration(
                      labelText: 'Localidade',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem<int?>(
                        value: null,
                        child: Text('Todas'),
                      ),
                      ...localidadesDisponiveis.map(
                        (localidade) => DropdownMenuItem<int?>(
                          value: localidade,
                          child: Text('Localidade $localidade'),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() => filtroLocalidade = value);
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

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

            const SizedBox(height: 12),

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
            }),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBarMonitor(),
    );
  }
}
