import 'package:dio/dio.dart';
import 'package:feirasystem/professor/professorModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfessorService {
  final Dio _dio;

  ProfessorService([Dio? dio])
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

  Future<List<Professor>> getProfessores() async {
    try {
      final response = await _dio.get('/professores');
      final List<dynamic> data = response.data['data'];
      return data.map((item) => Professor.fromJson(item)).toList();
    } catch (e) {
      throw 'Erro ao carregar professores: ${e.toString()}';
    }
  }

  Future<Professor> getProfessor(int id) async {
    try {
      final response = await _dio.get('/professores/$id');
      return Professor.fromJson(response.data['data']);
    } catch (e) {
      throw 'Erro ao carregar professor: ${e.toString()}';
    }
  }

  Future<Professor> createProfessor(Professor professor) async {
    try {
      final response = await _dio.post('/professores', data: {
        'data': {
          'nome': professor.nome,
          'idDepartamento': professor.idDepartamento,
        }
      });
      return Professor.fromJson(response.data['data']);
    } catch (e) {
      throw 'Erro ao criar professor: ${e.toString()}';
    }
  }

  Future<Professor> updateProfessor(int id, Professor professor) async {
    try {
      final response = await _dio.put('/professores/$id', data: {
        'data': {
          'nome': professor.nome,
          'idDepartamento': professor.idDepartamento,
        }
      });
      return Professor.fromJson(response.data['data']);
    } catch (e) {
      throw 'Erro ao atualizar professor: ${e.toString()}';
    }
  }

  Future<void> deleteProfessor(int id) async {
    try {
      await _dio.delete('/professores/$id');
    } catch (e) {
      throw 'Erro ao deletar professor: ${e.toString()}';
    }
  }
}
