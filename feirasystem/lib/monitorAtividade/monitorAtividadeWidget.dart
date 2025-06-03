import 'package:feirasystem/assets/bottomAppBarMonitor.dart';
import 'package:feirasystem/monitorAtividade/monitorAtividadeModel.dart';
import 'package:feirasystem/monitorAtividade/monitorAtividadeService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MonitorAtividades extends StatefulWidget {
  const MonitorAtividades({super.key});
  @override
  _MonitorAtividadesState createState() => _MonitorAtividadesState();
}

class _MonitorAtividadesState extends State<MonitorAtividades> {
  final MonitorAtividadeService _monitorAtividadeService =
      MonitorAtividadeService();

  late Future<List<MonitorAtividade>> _monitorAtividades;

  @override
  void initState() {
    super.initState();
    _atualizarMonitorAtividades();
  }

  Future<void> _atualizarMonitorAtividades() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _monitorAtividades = _monitorAtividadeService
          .getMonitorAtividadesPorMonitor(prefs.getInt('id')!);
    });
  }

  Future<void> _cancelarMonitorAtividade(
      MonitorAtividade monitorAtividade) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancelar sua inscrição nesta atividade?'),
        content: const Text(
            'Você tem certeza que deseja cancelar sua inscrição nesta atividade?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Voltar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      // TO DO AND TO DISCUSS
      _atualizarMonitorAtividades();
      _mostrarSnackBar('Inscrição cancelada com sucesso.');
    }
  }

  void _mostrarSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas atividades'),
      ),
      body: RefreshIndicator(
        onRefresh: _atualizarMonitorAtividades,
        child: FutureBuilder<List<dynamic>>(
          future: Future.wait([_monitorAtividades]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Nenhuma atividade encontrada.'));
            }

            final List<MonitorAtividade> monitorAtividades = snapshot.data![0];

            return ListView.builder(
              itemCount: monitorAtividades.length,
              itemBuilder: (context, index) {
                final monitorAtividade = monitorAtividades[index];
                return Dismissible(
                  key: Key(monitorAtividade.id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) =>
                      _cancelarMonitorAtividade(monitorAtividade),
                  child: ListTile(
                    title: const Text(''),
                    subtitle: Text(
                        'Esteve presente: ${monitorAtividade.estevePresente ? 'Sim' : 'Não'}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () =>
                              _cancelarMonitorAtividade(monitorAtividade),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomAppBarMonitor(),
    );
  }
}
