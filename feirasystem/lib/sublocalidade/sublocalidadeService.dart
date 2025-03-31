import 'package:dio/dio.dart';
import 'package:feirasystem/sublocalidade/sublocalidadeModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SublocalidadeService {
  final Dio _dio;

  SublocalidadeService([Dio? dio])
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

  Future<List<Sublocalidade>> getSublocalidades() async {
    try {
      final response = await _dio.get('/sublocalidades');
      final List<dynamic> data = response.data['data'];
      return data.map((item) => Sublocalidade.fromJson(item)).toList();
    } catch (e) {
      throw 'Erro ao carregar sublocalidades: ${e.toString()}';
    }
  }

  Future<Sublocalidade> getSublocalidade(int id) async {
    try {
      final response = await _dio.get('/sublocalidades/$id');
      return Sublocalidade.fromJson(response.data['data']);
    } catch (e) {
      throw 'Erro ao carregar sublocalidade: ${e.toString()}';
    }
  }

  Future<Sublocalidade> createSublocalidade(Sublocalidade sublocalidade) async {
    try {
      final response = await _dio.post('/sublocalidades', data: {
        'data': {
          'nome': sublocalidade.nome,
          'descricao': sublocalidade.descricao,
          'idLocalidade': sublocalidade.idLocalidade,
        }
      });
      return Sublocalidade.fromJson(response.data['data']);
    } catch (e) {
      throw 'Erro ao criar sublocalidade: ${e.toString()}';
    }
  }

  Future<Sublocalidade> updateSublocalidade(
      int id, Sublocalidade sublocalidade) async {
    try {
      final response = await _dio.put('/sublocalidades/$id', data: {
        'data': {
          'nome': sublocalidade.nome,
          'descricao': sublocalidade.descricao,
          'idLocalidade': sublocalidade.idLocalidade,
        }
      });
      return Sublocalidade.fromJson(response.data['data']);
    } catch (e) {
      throw 'Erro ao atualizar sublocalidade: ${e.toString()}';
    }
  }

  Future<void> deleteSublocalidade(int id) async {
    try {
      await _dio.delete('/sublocalidades/$id');
    } catch (e) {
      throw 'Erro ao deletar sublocalidade: ${e.toString()}';
    }
  }
}
