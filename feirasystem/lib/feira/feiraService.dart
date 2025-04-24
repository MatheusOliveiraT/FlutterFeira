import 'package:dio/dio.dart';
import 'package:feirasystem/feira/feiraModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeiraService {
  final Dio _dio;

  FeiraService([Dio? dio])
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

  Future<List<Feira>> getFeiras() async {
    try {
      final response = await _dio.get('/feiras');
      final List<dynamic> data = response.data;
      return data.map((item) => Feira.fromJson(item)).toList();
    } on DioException catch (e) {
      if (e.response?.data['mensagem'] != null) {
        throw '${e.response?.data['mensagem']}';
      } else {
        throw e.toString();
      }
    }
  }

  Future<Feira> getFeira(int id) async {
    try {
      final response = await _dio.get('/feiras/$id');
      return Feira.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.data['mensagem'] != null) {
        throw '${e.response?.data['mensagem']}';
      } else {
        throw e.toString();
      }
    }
  }

  Future<Feira> createFeira(Feira feira) async {
    try {
      final response = await _dio.post('/feiras', data: {
        'nome': feira.nome,
      });
      return Feira.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.data['mensagem'] != null) {
        throw '${e.response?.data['mensagem']}';
      } else {
        throw e.toString();
      }
    }
  }

  Future<void> updateFeira(int id, Feira feira) async {
    try {
      await _dio.put('/feiras/$id', data: {
        'nome': feira.nome,
      });
      return;
    } on DioException catch (e) {
      if (e.response?.data['mensagem'] != null) {
        throw '${e.response?.data['mensagem']}';
      } else {
        throw e.toString();
      }
    }
  }

  Future<void> deleteFeira(int id) async {
    try {
      await _dio.delete('/feiras/$id');
    } on DioException catch (e) {
      if (e.response?.data['mensagem'] != null) {
        throw '${e.response?.data['mensagem']}';
      } else {
        throw e.toString();
      }
    }
  }
}
