import 'package:dio/dio.dart';
import 'package:feirasystem/monitorAtividade/monitorAtividadeModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MonitorAtividadeService {
  final Dio _dio;

  MonitorAtividadeService([Dio? dio])
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: 'http://localhost:3000',
              headers: {
                'Content-Type': 'application/json',
              },
            )) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('auth_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        if (e.response?.statusCode == 401) {
          // TO DO: INVALID/EXPIRED TOKEN
        }
        return handler.next(e);
      },
    ));
  }

  Future<List<MonitorAtividade>> getMonitorAtividades() async {
    try {
      final response = await _dio.get('/monitorAtividades');
      final List<dynamic> data = response.data;
      return data.map((item) => MonitorAtividade.fromJson(item)).toList();
    } catch (e) {
      throw 'Erro ao carregar monitorAtividades: ${e.toString()}';
    }
  }

  Future<List<MonitorAtividade>> getMonitorAtividadesPorMonitor(
      int idMonitor) async {
    try {
      final response =
          await _dio.get('/monitorAtividades&idMonitor=$idMonitor');
      final List<dynamic> data = response.data;
      return data.map((item) => MonitorAtividade.fromJson(item)).toList();
    } catch (e) {
      throw 'Erro ao carregar monitorAtividades: ${e.toString()}';
    }
  }

  Future<MonitorAtividade> getMonitorAtividade(int id) async {
    try {
      final response = await _dio.get('/monitorAtividades/$id');
      return MonitorAtividade.fromJson(response.data);
    } catch (e) {
      throw 'Erro ao carregar monitorAtividade: ${e.toString()}';
    }
  }

  Future<MonitorAtividade> createMonitorAtividade(
      MonitorAtividade monitorAtividade) async {
    try {
      final response = await _dio.post('/monitorAtividades', data: {
        'estevePresente': monitorAtividade.estevePresente.toString(),
        'idMonitor': monitorAtividade.idMonitor.toString(),
        'idAgendamentoAtividadeFeira':
            monitorAtividade.idAgendamentoAtividadeFeira.toString(),
      });
      return MonitorAtividade.fromJson(response.data);
    } catch (e) {
      throw 'Erro ao criar monitorAtividade: ${e.toString()}';
    }
  }

  Future<void> updateMonitorAtividade(
      int id, MonitorAtividade monitorAtividade) async {
    try {
      await _dio.put('/monitorAtividades/$id', data: {
        'estevePresente': monitorAtividade.estevePresente.toString(),
        'idMonitor': monitorAtividade.idMonitor.toString(),
        'idAgendamentoAtividadeFeira':
            monitorAtividade.idAgendamentoAtividadeFeira.toString(),
      });
      return;
    } catch (e) {
      throw 'Erro ao atualizar monitorAtividade: ${e.toString()}';
    }
  }

  Future<void> deleteMonitorAtividade(int id) async {
    try {
      await _dio.delete('/monitorAtividades/$id');
    } catch (e) {
      throw 'Erro ao deletar monitorAtividade: ${e.toString()}';
    }
  }
}
