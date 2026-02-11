// lib/monitorAtividade/monitorAtividadeWidget.dart

import 'package:feirasystem/assets/customSnackBar.dart'; 
import 'monitorAtividadeModel.dart';
import 'monitorAtividadeService.dart';
import 'ponto_atividade_dto.dart';
import 'ponto_service.dart';
import 'package:feirasystem/assets/bottomAppBarMonitor.dart';
import 'package:flutter/material.dart';

class MonitorAtividades extends StatefulWidget {
  const MonitorAtividades({super.key});
  @override
  _MonitorAtividadesState createState() => _MonitorAtividadesState();
}

class _MonitorAtividadesState extends State<MonitorAtividades> {
  final MonitorAtividadeService _monitorAtividadeService = MonitorAtividadeService();
  final PontoService _pontoService = pontoService; 

  Future<List<MonitorAtividade>>? _monitorAtividades;
  late int _idMonitor = 0; 

  @override
  void initState() {
    super.initState();
    _monitorAtividades = _inicializarDados();
  }
  
  Future<List<MonitorAtividade>> _inicializarDados() async {
    _idMonitor = 1; 
    try {
      return await _monitorAtividadeService.getMonitorAtividadesPorMonitor(_idMonitor);
    } catch (e) {
      return [];
    }
  }


  Future<void> _handleTrocaStatusSala(MonitorAtividade atividade) async {
    
    String novoStatus = (atividade.statusAtividade == 'OCIOSA') ? 'OCUPADA' : 'OCIOSA';
    
    // Chama o serviço
    bool sucesso = await _monitorAtividadeService.trocarStatusDaSala(
      atividade.idAtividadeReal, 
      novoStatus
    );

    if (sucesso) {
      _mostrarSnackBar('Sala marcada como $novoStatus', isError: false);
      setState(() {
        _monitorAtividades = _inicializarDados(); 
      });
    } else {
      _mostrarSnackBar('Erro ao mudar status. Verifique se a rota /atividade existe no backend.', isError: true);
    }
  }

  Future<void> _handlePonto(MonitorAtividade atividade) async {
    try {
      final PontoAtividadeDto registro = await _pontoService.registrarPonto(
        atividade: atividade, 
      );
      setState(() {
        _monitorAtividades = _inicializarDados();
      }); 
      _mostrarSnackBar('Status atualizado para: ${registro.novoStatus}', isError: false);
    } catch (e) {
      _mostrarSnackBar('Erro ao registrar ponto: $e', isError: true);
    }
  }
  
  Future<void> _cancelarMonitorAtividade(MonitorAtividade monitorAtividade) async {
     
  }

  void _mostrarSnackBar(String message, {bool isError = false}) {
    showCustomSnackBar(context, message, tipo: isError ? 'erro' : 'sucesso');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minhas atividades')),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() { _monitorAtividades = _inicializarDados(); });
        },
        child: FutureBuilder<List<MonitorAtividade>>(
          future: _monitorAtividades, 
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
            if (!snapshot.hasData || snapshot.data!.isEmpty) return const Center(child: Text('Nenhuma atividade encontrada.'));

            final List<MonitorAtividade> monitorAtividades = snapshot.data!;

            return ListView.builder(
              itemCount: monitorAtividades.length,
              itemBuilder: (context, index) {
                final monitorAtividade = monitorAtividades[index];
                
                
                final bool isCheckedIn = _pontoService.isMonitorCheckedIn(monitorAtividade.idAgendamentoAtividadeFeira);
                final bool isOcupada = monitorAtividade.statusAtividade == 'OCUPADA';
                
                return Card( 
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(monitorAtividade.nomeAtividade, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Meu Ponto: ${isCheckedIn ? '🟢 Em Andamento' : '⚪ Pendente'}'),
                            const SizedBox(height: 5),
                            
                            // --- O STATUS DA SALA AGORA APARECE AQUI ---
                            Row(
                              children: [
                                Text('Sala: '),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: isOcupada ? Colors.orange.shade100 : Colors.green.shade100,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: isOcupada ? Colors.orange : Colors.green)
                                  ),
                                  child: Text(
                                    monitorAtividade.statusAtividade,
                                    style: TextStyle(
                                      color: isOcupada ? Colors.orange.shade900 : Colors.green.shade900,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      
                      // --- BARRA DE BOTÕES ---
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // 1. Botão de STATUS DA SALA (NOVO)
                            TextButton.icon(
                              onPressed: () => _handleTrocaStatusSala(monitorAtividade),
                              icon: Icon(isOcupada ? Icons.check_circle_outline : Icons.warning_amber_rounded),
                              label: Text(isOcupada ? "Liberar Sala" : "Lotar Sala"),
                              style: TextButton.styleFrom(foregroundColor: isOcupada ? Colors.green : Colors.orange),
                            ),
                            
                            const SizedBox(width: 10),

                            // 2. Botão de CHECK-IN (ANTIGO)
                            ElevatedButton(
                              onPressed: () => _handlePonto(monitorAtividade),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isCheckedIn ? Colors.red.shade700 : Colors.green.shade700,
                              ),
                              child: Text(isCheckedIn ? 'CHECK-OUT' : 'CHECK-IN', style: const TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      )
                    ],
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