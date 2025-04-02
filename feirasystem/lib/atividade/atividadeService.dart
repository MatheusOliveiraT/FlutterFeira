import 'package:dio/dio.dart';
import 'package:feirasystem/atividade/atividadeModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AtividadeLocalidadeService {
  final Dio _dio;

  AtividadeLocalidadeService([Dio? dio])
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

  Future<List<AtividadeLocalidade>> getAtividades() async {
    try {
      final response = await _dio.get('/atividadeLocalidades');
      final List<dynamic> data = response.data['data'];
      return data.map((item) => AtividadeLocalidade.fromJson(item)).toList();
    } catch (e) {
      throw 'Erro ao carregar atividades: ${e.toString()}';
    }
  }

  Future<AtividadeLocalidade> getAtividade(int id) async {
    try {
      final response = await _dio.get('/atividadeLocalidades/$id');
      return AtividadeLocalidade.fromJson(response.data['data']);
    } catch (e) {
      throw 'Erro ao carregar atividade: ${e.toString()}';
    }
  }

  Future<AtividadeLocalidade> createAtividade(
      AtividadeLocalidade atividade) async {
    try {
      final response = await _dio.post('/atividadeLocalidades/', data: {
        'data': {
          'nome': atividade.nome,
          'descricao': atividade.descricao,
          'quantidadeMonitores': atividade.quantidadeMonitores,
          'idLocalidade': atividade.idLocalidade,
          'idProfessor': atividade.idProfessor,
          'idFeira': atividade.idFeira,
        }
      });
      return AtividadeLocalidade.fromJson(response.data['data']);
    } catch (e) {
      throw 'Erro ao criar atividade: ${e.toString()}';
    }
  }

  Future<AtividadeLocalidade> updateAtividade(
      int id, AtividadeLocalidade atividade) async {
    try {
      final response = await _dio.put('/atividadeLocalidades/$id', data: {
        'data': {
          'nome': atividade.nome,
          'descricao': atividade.descricao,
          'quantidadeMonitores': atividade.quantidadeMonitores,
          'idLocalidade': atividade.idLocalidade,
          'idProfessor': atividade.idProfessor,
          'idFeira': atividade.idFeira,
        }
      });
      return AtividadeLocalidade.fromJson(response.data['data']);
    } catch (e) {
      throw 'Erro ao atualizar atividade: ${e.toString()}';
    }
  }

  Future<void> deleteAtividade(int id) async {
    try {
      await _dio.delete('/atividadeLocalidades/$id');
    } catch (e) {
      throw 'Erro ao deletar atividade: ${e.toString()}';
    }
  }
}

class AtividadeSublocalidadeService {
  final Dio _dio;

  AtividadeSublocalidadeService([Dio? dio])
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

  Future<List<AtividadeSublocalidade>> getAtividades() async {
    try {
      final response = await _dio.get('/atividadeSublocalidades');
      final List<dynamic> data = response.data['data'];
      return data.map((item) => AtividadeSublocalidade.fromJson(item)).toList();
    } catch (e) {
      throw 'Erro ao carregar atividades: ${e.toString()}';
    }
  }

  Future<AtividadeSublocalidade> getAtividade(int id) async {
    try {
      final response = await _dio.get('/atividadeSublocalidades/$id');
      return AtividadeSublocalidade.fromJson(response.data['data']);
    } catch (e) {
      throw 'Erro ao carregar atividade: ${e.toString()}';
    }
  }

  Future<AtividadeSublocalidade> createAtividade(
      AtividadeSublocalidade atividade) async {
    try {
      final response = await _dio.post('/atividadeSublocalidades/', data: {
        'data': {
          'nome': atividade.nome,
          'descricao': atividade.descricao,
          'quantidadeMonitores': atividade.quantidadeMonitores,
          'duracaoSecao': atividade.duracaoSecao,
          'capacidadeVisitantes': atividade.capacidadeVisitantes,
          'idSublocalidade': atividade.idSublocalidade,
          'idProfessor': atividade.idProfessor,
          'idFeira': atividade.idFeira,
          'status': atividade.status.descricao,
          'tipo': atividade.status.descricao,
        }
      });
      return AtividadeSublocalidade.fromJson(response.data['data']);
    } catch (e) {
      throw 'Erro ao criar atividade: ${e.toString()}';
    }
  }

  Future<AtividadeSublocalidade> updateAtividade(
      int id, AtividadeSublocalidade atividade) async {
    try {
      final response = await _dio.put('/atividadeSublocalidades/$id', data: {
        'data': {
          'nome': atividade.nome,
          'descricao': atividade.descricao,
          'quantidadeMonitores': atividade.quantidadeMonitores,
          'duracaoSecao': atividade.duracaoSecao,
          'capacidadeVisitantes': atividade.capacidadeVisitantes,
          'idSublocalidade': atividade.idSublocalidade,
          'idProfessor': atividade.idProfessor,
          'idFeira': atividade.idFeira,
          'status': atividade.status.descricao,
          'tipo': atividade.status.descricao,
        }
      });
      return AtividadeSublocalidade.fromJson(response.data['data']);
    } catch (e) {
      throw 'Erro ao atualizar atividade: ${e.toString()}';
    }
  }

  Future<void> deleteAtividade(int id) async {
    try {
      await _dio.delete('/atividadeSublocalidades/$id');
    } catch (e) {
      throw 'Erro ao deletar atividade: ${e.toString()}';
    }
  }
}
