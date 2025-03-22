import 'package:dio/dio.dart';
import 'package:feirasystem/agendamentoFeira/agendamentoFeiraModel.dart'; // Importando o modelo AgendamentoFeira
import 'package:shared_preferences/shared_preferences.dart';

class AgendamentoFeiraService {
  final Dio _dio;

  AgendamentoFeiraService([Dio? dio])
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: 'https://sua-api.com', // Defina a URL base da API
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

  // Método para pegar todos os agendamentos de feira
  Future<List<AgendamentoFeira>> getAgendamentos() async {
    try {
      final response = await _dio.get('/agendamentoFeira');
      final List<dynamic> data = response.data['data'];
      return data.map((item) => AgendamentoFeira.fromJson(item)).toList();
    } catch (e) {
      throw 'Erro ao carregar agendamentos: ${e.toString()}';
    }
  }

  // Método para pegar um agendamento específico
  Future<AgendamentoFeira> getAgendamento(String id) async {
    try {
      final response = await _dio.get('/agendamentoFeira/$id');
      return AgendamentoFeira.fromJson(response.data['data']);
    } catch (e) {
      throw 'Erro ao carregar agendamento: ${e.toString()}';
    }
  }

  // Método para criar um novo agendamento de feira
  Future<AgendamentoFeira> createAgendamento(
      AgendamentoFeira agendamento) async {
    try {
      final response = await _dio.post('/agendamentoFeira', data: {
        'data': {
          'id': agendamento.id,
          'data': agendamento.data.toIso8601String(),
          'turno': agendamento.turno.descricao,
          'feira': agendamento.feira.toJson(),
        }
      });
      return AgendamentoFeira.fromJson(response.data['data']);
    } catch (e) {
      throw 'Erro ao criar agendamento: ${e.toString()}';
    }
  }

  // Método para atualizar um agendamento existente
  Future<AgendamentoFeira> updateAgendamento(
      String id, AgendamentoFeira agendamento) async {
    try {
      final response = await _dio.put('/agendamentoFeira/$id', data: {
        'data': {
          'id': agendamento.id,
          'data': agendamento.data.toIso8601String(),
          'turno': agendamento.turno.descricao,
          'feira': agendamento.feira.toJson(),
        }
      });
      return AgendamentoFeira.fromJson(response.data['data']);
    } catch (e) {
      throw 'Erro ao atualizar agendamento: ${e.toString()}';
    }
  }

  // Método para deletar um agendamento
  Future<void> deleteAgendamento(String id) async {
    try {
      await _dio.delete('/agendamentoFeira/$id');
    } catch (e) {
      throw 'Erro ao deletar agendamento: ${e.toString()}';
    }
  }
}
