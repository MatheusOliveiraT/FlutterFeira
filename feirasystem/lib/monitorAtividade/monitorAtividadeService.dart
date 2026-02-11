import 'package:dio/dio.dart';
import 'package:feirasystem/monitorAtividade/monitorAtividadeModel.dart';

class MonitorAtividadeService {
  final Dio _dio = Dio();

  
  final String baseUrl = 'http://localhost:3000'; 

  Future<List<MonitorAtividade>> getMonitorAtividadesPorMonitor(int idMonitor) async {
    try {
      print("🔍 Buscando TODAS as atividades no backend...");
      
      // Chama a rota correta
      final response = await _dio.get('$baseUrl/monitores/atividade');

      if (response.statusCode == 200) {
        
        List<dynamic> listaCompleta = response.data['monitorAtividades'];
        
        print("📦 Dados recebidos do Banco: $listaCompleta");
        
        return listaCompleta.map((json) => MonitorAtividade.fromJson(json)).toList();
      } else {
        throw Exception('Erro ao carregar atividades: ${response.statusCode}');
      }
    } catch (e) {
      print("❌ Erro na conexão GET: $e");
      throw Exception('Não foi possível conectar ao servidor.');
    }
  }
  

  
  Future<bool> trocarStatusDaSala(int idAtividade, String novoStatus) async {
    try {
      
      final response = await _dio.put(
        '$baseUrl/atividades/$idAtividade',
        data: {'status': novoStatus},
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Erro ao trocar status: $e");
      return false;
    }
  }
} // Fim da classe
