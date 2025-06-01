import 'package:dio/dio.dart';
import 'package:feirasystem/agendamentoAtividadeFeira/agendamentoAtividadeFeiraModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgendamentoAtividadeFeiraService {
  final Dio _dio;

  AgendamentoAtividadeFeiraService([Dio? dio])
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

  Future<List<AgendamentoAtividadeFeira>> getAgendamentos() async {
    try {
      final response = await _dio.get('/agendamentoAtividadeFeiras');
      final List<dynamic> data = response.data;
      return data
          .map((item) => AgendamentoAtividadeFeira.fromJson(item))
          .toList();
    } catch (e) {
      throw 'Erro ao carregar agendamentos: ${e.toString()}';
    }
  }

  Future<AgendamentoAtividadeFeira> getAgendamento(int id) async {
    try {
      final response = await _dio.get('/agendamentoAtividadeFeiras/$id');
      return AgendamentoAtividadeFeira.fromJson(response.data);
    } catch (e) {
      throw 'Erro ao carregar agendamento: ${e.toString()}';
    }
  }

  Future<AgendamentoAtividadeFeira> createAgendamento(
      AgendamentoAtividadeFeira agendamento) async {
    try {
      final response = await _dio.post('/agendamentoAtividadeFeiras', data: {
        'quantidadeMonitoresInscrito':
            agendamento.quantidadeMonitoresInscrito.toString(),
        'idAgendamentoFeira': agendamento.idAgendamentoFeira.toString(),
        'idAtividade': agendamento.idAtividade.toString(),
      });
      return AgendamentoAtividadeFeira.fromJson(response.data);
    } catch (e) {
      throw 'Erro ao criar agendamento: ${e.toString()}';
    }
  }

  Future<void> updateAgendamento(
      int id, AgendamentoAtividadeFeira agendamento) async {
    try {
      await _dio.put('/agendamentoAtividadeFeiras/$id', data: {
        'quantidadeMonitoresInscrito':
            agendamento.quantidadeMonitoresInscrito.toString(),
        'idAgendamentoFeira': agendamento.idAgendamentoFeira.toString(),
        'idAtividade': agendamento.idAtividade.toString(),
      });
      return;
    } catch (e) {
      throw 'Erro ao atualizar agendamento: ${e.toString()}';
    }
  }

  Future<void> deleteAgendamento(int id) async {
    try {
      await _dio.delete('/agendamentoAtividadeFeiras/$id');
    } catch (e) {
      throw 'Erro ao deletar agendamento: ${e.toString()}';
    }
  }
}
