import 'package:dio/dio.dart';
import 'package:feirasystem/departamento/departamentoModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DepartamentoService {
  final Dio _dio;

  DepartamentoService([Dio? dio])
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

  Future<List<Departamento>> getDepartamentos() async {
    try {
      final response = await _dio.get('/departamentos');
      final List<dynamic> data = response.data['data'];
      return data.map((item) => Departamento.fromJson(item)).toList();
    } catch (e) {
      throw 'Erro ao carregar departamentos: ${e.toString()}';
    }
  }

  Future<Departamento> getDepartamento(int id) async {
    try {
      final response = await _dio.get('/departamentos/$id');
      return Departamento.fromJson(response.data['data']);
    } catch (e) {
      throw 'Erro ao carregar departamento: ${e.toString()}';
    }
  }

  Future<Departamento> createDepartamento(Departamento departamento) async {
    try {
      final response = await _dio.post('/departamentos', data: {
        'data': {
          'nome': departamento.nome,
        }
      });
      return Departamento.fromJson(response.data['data']);
    } catch (e) {
      throw 'Erro ao criar departamento: ${e.toString()}';
    }
  }

  Future<Departamento> updateDepartamento(
      int id, Departamento departamento) async {
    try {
      final response = await _dio.put('/departamentos/$id', data: {
        'data': {
          'nome': departamento.nome,
        }
      });
      return Departamento.fromJson(response.data['data']);
    } catch (e) {
      throw 'Erro ao atualizar departamento: ${e.toString()}';
    }
  }

  Future<void> deleteDepartamento(int id) async {
    try {
      await _dio.delete('/departamentos/$id');
    } catch (e) {
      throw 'Erro ao deletar departamento: ${e.toString()}';
    }
  }
}
