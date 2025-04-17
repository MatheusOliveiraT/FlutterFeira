import 'package:dio/dio.dart';
import 'package:feirasystem/atividade/atividadeModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AtividadeLocalidadeService {
  final Dio _dio;

  AtividadeLocalidadeService([Dio? dio])
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

  Future<List<AtividadeLocalidade>> getAtividades() async {
    try {
      final response = await _dio.get('/atividadeLocalidades');
      final List<dynamic> data = response.data;
      return data.map((item) => AtividadeLocalidade.fromJson(item)).toList();
    } catch (e) {
      throw 'Erro ao carregar atividades: ${e.toString()}';
    }
  }

  Future<AtividadeLocalidade> getAtividade(int id) async {
    try {
      final response = await _dio.get('/atividadeLocalidades/$id');
      return AtividadeLocalidade.fromJson(response.data);
    } catch (e) {
      throw 'Erro ao carregar atividade: ${e.toString()}';
    }
  }

  Future<AtividadeLocalidade> createAtividade(
      AtividadeLocalidade atividade) async {
    try {
      final response = await _dio.post('/atividadeLocalidades/', data: {
        'nome': atividade.nome,
        'descricao': atividade.descricao,
        'quantidadeMonitores': atividade.quantidadeMonitores.toString(),
        'idLocalidade': atividade.idLocalidade.toString(),
        'idProfessor': atividade.idProfessor.toString(),
        'idFeira': atividade.idFeira.toString(),
      });
      return AtividadeLocalidade.fromJson(response.data);
    } catch (e) {
      throw 'Erro ao criar atividade: ${e.toString()}';
    }
  }

  Future<void> updateAtividade(int id, AtividadeLocalidade atividade) async {
    try {
      await _dio.put('/atividadeLocalidades/$id', data: {
        'nome': atividade.nome,
        'descricao': atividade.descricao,
        'quantidadeMonitores': atividade.quantidadeMonitores.toString(),
        'idLocalidade': atividade.idLocalidade.toString(),
        'idProfessor': atividade.idProfessor.toString(),
        'idFeira': atividade.idFeira.toString(),
      });
      return;
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

  Future<List<AtividadeSublocalidade>> getAtividades() async {
    try {
      final response = await _dio.get('/atividadeSublocalidades');
      final List<dynamic> data = response.data;
      return data.map((item) => AtividadeSublocalidade.fromJson(item)).toList();
    } catch (e) {
      throw 'Erro ao carregar atividades: ${e.toString()}';
    }
  }

  Future<AtividadeSublocalidade> getAtividade(int id) async {
    try {
      final response = await _dio.get('/atividadeSublocalidades/$id');
      return AtividadeSublocalidade.fromJson(response.data);
    } catch (e) {
      throw 'Erro ao carregar atividade: ${e.toString()}';
    }
  }

  Future<AtividadeSublocalidade> createAtividade(
      AtividadeSublocalidade atividade) async {
    try {
      final response = await _dio.post('/atividadeSublocalidades/', data: {
        'nome': atividade.nome,
        'descricao': atividade.descricao,
        'quantidadeMonitores': atividade.quantidadeMonitores.toString(),
        'duracao': atividade.duracaoSecao.toString(),
        'capacidadeVisitante': atividade.capacidadeVisitantes.toString(),
        'idSublocalidade': atividade.idSublocalidade.toString(),
        'idProfessor': atividade.idProfessor.toString(),
        'idFeira': atividade.idFeira.toString(),
        'status': atividade.status.descricao,
        'tipo': atividade.tipo.descricao,
      });
      return AtividadeSublocalidade.fromJson(response.data);
    } catch (e) {
      throw 'Erro ao criar atividade: ${e.toString()}';
    }
  }

  Future<void> updateAtividade(int id, AtividadeSublocalidade atividade) async {
    try {
      await _dio.put('/atividadeSublocalidades/$id', data: {
        'nome': atividade.nome,
        'descricao': atividade.descricao,
        'quantidadeMonitores': atividade.quantidadeMonitores.toString(),
        'duracao': atividade.duracaoSecao.toString(),
        'capacidadeVisitante': atividade.capacidadeVisitantes.toString(),
        'idSublocalidade': atividade.idSublocalidade.toString(),
        'idProfessor': atividade.idProfessor.toString(),
        'idFeira': atividade.idFeira.toString(),
        'status': atividade.status.descricao,
        'tipo': atividade.tipo.descricao,
      });
      return;
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
