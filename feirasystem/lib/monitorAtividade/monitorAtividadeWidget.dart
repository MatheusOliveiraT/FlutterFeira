// lib/monitorAtividade/monitorAtividadeWidget.dart


import 'package:feirasystem/assets/mockBuilder.dart'; 
import 'package:feirasystem/atividade/atividadeModel.dart';

import 'package:feirasystem/assets/customSnackBar.dart'; 

import 'monitorAtividadeModel.dart';
import 'monitorAtividadeService.dart';
import 'ponto_atividade_dto.dart';
import 'ponto_service.dart';

import 'package:feirasystem/assets/bottomAppBarMonitor.dart';
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
  final PontoService _pontoService = pontoService; 

  Future<List<MonitorAtividade>>? _monitorAtividades;
  late int _idMonitor = 0; 

  @override
  void initState() {
    super.initState();
    _monitorAtividades = _inicializarDados();
  }
  
  Future<List<MonitorAtividade>> _inicializarDados() async {
    // 1. Define um ID fixo (já que não temos login)
    _idMonitor = 123; 

  
    print("Carregando dados do MockBuilder...");
    List<Atividade> atividadesDoMock = MockBuilder.retrieveAtividades();

    
    List<MonitorAtividade> listaConvertida = atividadesDoMock.map((atividade) {
      return MonitorAtividade(
        id: atividade.id,
        estevePresente: false,
        idMonitor: _idMonitor,
        idAgendamentoAtividadeFeira: atividade.id!,
        
        
        nomeAtividade: atividade.nome ?? "Atividade sem nome",
        turno: "Integral", 
        nomeDaFeira: "Feira de Profissões",
      );
    }).toList();

    await Future.delayed(const Duration(milliseconds: 500));
    return listaConvertida;
  }

  Future<void> _handlePonto(MonitorAtividade atividade) async {
    try {
      final PontoAtividadeDto registro = await _pontoService.registrarPonto(
        atividade: atividade, 
      );
      final String acao = registro.novoStatus;
      
      setState(() {}); 
      
      
      _mostrarSnackBar(
        'Status atualizado para: $acao', 
        isError: false
      );

    } catch (e) {
      
      _mostrarSnackBar(
        'Erro ao registrar ponto: $e', 
        isError: true
      );
    }
  }
  
  Future<void> _cancelarMonitorAtividade(MonitorAtividade monitorAtividade) async {
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
      setState(() {
        _monitorAtividades = _inicializarDados();
      });
      
      _mostrarSnackBar('Inscrição cancelada com sucesso.', isError: false);
    }
  }

  void _mostrarSnackBar(String message, {bool isError = false}) {
    showCustomSnackBar(
      context,
      message,
      tipo: isError ? 'erro' : 'sucesso',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas atividades'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _monitorAtividades = _inicializarDados();
          });
        },
        child: FutureBuilder<List<MonitorAtividade>>(
          future: _monitorAtividades, 
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Nenhuma atividade encontrada.'));
            }

            final List<MonitorAtividade> monitorAtividades = snapshot.data!;

            return ListView.builder(
              itemCount: monitorAtividades.length,
              itemBuilder: (context, index) {
                final monitorAtividade = monitorAtividades[index];
                final idAgendamento = monitorAtividade.idAgendamentoAtividadeFeira; 
                
                final bool isCheckedIn = _pontoService.isMonitorCheckedIn(idAgendamento);
                final String buttonText = isCheckedIn ? 'CHECK-OUT' : 'CHECK-IN';
                final Color buttonColor = isCheckedIn ? Colors.red.shade700 : Colors.green.shade700;

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
                    title: Text(monitorAtividade.nomeAtividade), 
                    subtitle: Text(
                        'Status: ${isCheckedIn ? 'Em Andamento' : 'Pendente'}'), 
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () => _handlePonto(monitorAtividade),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          ),
                          child: Text(
                            buttonText,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
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