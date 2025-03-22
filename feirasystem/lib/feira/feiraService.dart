import 'package:dio/dio.dart';
import 'package:feirasystem/feira/feiraModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeiraService {
  final Dio _dio;

  FeiraService([Dio? dio])
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

  Future<List<Feira>> getFeiras() async {
    try {
      final response = await _dio.get('/feira');
      final List<dynamic> data = response.data['data'];
      return data.map((item) => Feira.fromJson(item)).toList();
    } catch (e) {
      throw 'Erro ao carregar feiras: ${e.toString()}';
    }
  }

  Future<Feira> getFeira(String id) async {
    try {
      final response = await _dio.get('/feira/$id');
      return Feira.fromJson(response.data['data']);
    } catch (e) {
      throw 'Erro ao carregar feira: ${e.toString()}';
    }
  }

  Future<Feira> createFeira(Feira feira) async {
    try {
      final response = await _dio.post('/feira', data: {
        'data': {
          'nome': feira.nome,
        }
      });
      return Feira.fromJson(response.data['data']);
    } catch (e) {
      throw 'Erro ao criar feira: ${e.toString()}';
    }
  }

  Future<Feira> updateFeira(String id, Feira feira) async {
    try {
      final response = await _dio.put('/feira/$id', data: {
        'data': {
          'nome': feira.nome,
        }
      });
      return Feira.fromJson(response.data['data']);
    } catch (e) {
      throw 'Erro ao atualizar feira: ${e.toString()}';
    }
  }

  Future<void> deleteFeira(String id) async {
    try {
      await _dio.delete('/feira/$id');
    } catch (e) {
      throw 'Erro ao deletar feira: ${e.toString()}';
    }
  }
}
