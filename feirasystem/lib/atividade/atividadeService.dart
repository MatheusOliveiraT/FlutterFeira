import 'package:dio/dio.dart';
import 'package:feirasystem/atividade/atividadeModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AtividadeService {
  final Dio _dio;

  AtividadeService([Dio? dio])
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

  Future<List<Atividade>> getAtividades() async {
    try {
      final response = await _dio.get('/atividades');
      final List<dynamic> data = response.data;
      return data.map((item) => Atividade.fromJson(item)).toList();
    } catch (e) {
      throw 'Erro ao carregar atividades: ${e.toString()}';
    }
  }

  Future<Atividade> getAtividade(int id) async {
    try {
      final response = await _dio.get('/atividades/$id');
      return Atividade.fromJson(response.data);
    } catch (e) {
      throw 'Erro ao carregar atividade: ${e.toString()}';
    }
  }

  Future<Atividade> createAtividade(Atividade atividade) async {
    try {
      if (atividade.tipoAtividade == TipoAtividade.LOCALIDADE) {
        final response = await _dio.post('/atividades/', data: {
          'nome': atividade.nome,
          'descricao': atividade.descricao,
          'quantidadeMonitores': atividade.quantidadeMonitores.toString(),
          'idProfessor': atividade.idProfessor.toString(),
          'idFeira': atividade.idFeira.toString(),
          'idLocalidade': atividade.idLocalidade.toString(),
          'tipoAtividade': atividade.tipoAtividade.descricao,
        });
        return Atividade.fromJson(response.data);
      } else {
        final response = await _dio.post('/atividades/', data: {
          'nome': atividade.nome,
          'descricao': atividade.descricao,
          'quantidadeMonitores': atividade.quantidadeMonitores.toString(),
          'tipoAtividade': atividade.tipoAtividade.descricao,
          'idProfessor': atividade.idProfessor.toString(),
          'idFeira': atividade.idFeira.toString(),
          'idSublocalidade': atividade.idSublocalidade.toString(),
          'tipo': atividade.tipo!.descricao,
          'status': atividade.status!.descricao,
          'capacidadeVisitantes': atividade.capacidadeVisitantes.toString(),
          'duracaoSecao': atividade.duracaoSecao.toString(),
        });
        return Atividade.fromJson(response.data);
      }
    } catch (e) {
      throw 'Erro ao criar atividade: ${e.toString()}';
    }
  }

  Future<void> updateAtividade(int id, Atividade atividade) async {
    try {
      if (atividade.tipoAtividade == TipoAtividade.LOCALIDADE) {
        await _dio.put('/atividades/$id', data: {
          'nome': atividade.nome,
          'descricao': atividade.descricao,
          'quantidadeMonitores': atividade.quantidadeMonitores.toString(),
          'idProfessor': atividade.idProfessor.toString(),
          'idFeira': atividade.idFeira.toString(),
          'idLocalidade': atividade.idLocalidade.toString(),
          'tipoAtividade': atividade.tipoAtividade.descricao,
        });
      } else {
        await _dio.put('/atividades/$id', data: {
          'nome': atividade.nome,
          'descricao': atividade.descricao,
          'quantidadeMonitores': atividade.quantidadeMonitores.toString(),
          'tipoAtividade': atividade.tipoAtividade.descricao,
          'idProfessor': atividade.idProfessor.toString(),
          'idFeira': atividade.idFeira.toString(),
          'idSublocalidade': atividade.idSublocalidade.toString(),
          'tipo': atividade.tipo!.descricao,
          'status': atividade.status!.descricao,
          'capacidadeVisitantes': atividade.capacidadeVisitantes.toString(),
          'duracaoSecao': atividade.duracaoSecao.toString(),
        });
      }
      return;
    } catch (e) {
      throw 'Erro ao atualizar atividade: ${e.toString()}';
    }
  }

  Future<void> deleteAtividade(int id) async {
    try {
      await _dio.delete('/atividades/$id');
    } catch (e) {
      throw 'Erro ao deletar atividade: ${e.toString()}';
    }
  }
}
