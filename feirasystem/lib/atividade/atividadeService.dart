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
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('auth_token');

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  Future<List<Atividade>> getAtividades() async {
    try {
      final response = await _dio.get('/atividades');

      print('STATUS CODE: ${response.statusCode}');
      print('DATA BRUTA: ${response.data}');

      final data = response.data;

      if (data is Map && data['atividades'] != null) {
        return (data['atividades'] as List)
            .map((e) => Atividade.fromJson(e))
            .toList();
      }

      if (data is List) {
        return data.map((e) => Atividade.fromJson(e)).toList();
      }

      return [];
    } catch (e) {
      print('ERRO SERVICE: $e');
      rethrow;
    }
  }


  Future<Atividade> getAtividade(int id) async {
    try {
      final response = await _dio.get('/atividades/$id');
      return Atividade.fromJson(response.data);
    } catch (e) {
      throw 'Erro ao carregar atividade: $e';
    }
  }

  Future<Atividade> createAtividade(Atividade atividade) async {
    try {
      final Map<String, dynamic> payload = {
        'nome': atividade.nome,
        'descricao': atividade.descricao,
        'quantidadeMonitores': atividade.quantidadeMonitores,
        'idProfessor': atividade.idProfessor,
        'idFeira': atividade.idFeira,
        'tipoAtividade': atividade.tipoAtividade.descricao,
      };

      if (atividade.tipoAtividade == TipoAtividade.LOCALIDADE) {
        payload['idLocalidade'] = atividade.idLocalidade;
      } else {
        payload.addAll({
          'idSublocalidade': atividade.idSublocalidade,
          'tipo': atividade.tipo!.descricao,
          'status': atividade.status!.descricao,
          'capacidadeVisitantes': atividade.capacidadeVisitantes,
          'duracaoSecao': atividade.duracaoSecao,
        });
      }

      final response = await _dio.post('/atividades', data: payload);
      return Atividade.fromJson(response.data);
    } catch (e) {
      throw 'Erro ao criar atividade: $e';
    }
  }

  Future<void> updateAtividade(int id, Atividade atividade) async {
    try {
      final Map<String, dynamic> payload = {
        'nome': atividade.nome,
        'descricao': atividade.descricao,
        'quantidadeMonitores': atividade.quantidadeMonitores,
        'idProfessor': atividade.idProfessor,
        'idFeira': atividade.idFeira,
        'tipoAtividade': atividade.tipoAtividade.descricao,
      };

      if (atividade.tipoAtividade == TipoAtividade.LOCALIDADE) {
        payload['idLocalidade'] = atividade.idLocalidade;
      } else {
        payload.addAll({
          'idSublocalidade': atividade.idSublocalidade,
          'tipo': atividade.tipo!.descricao,
          'status': atividade.status!.descricao,
          'capacidadeVisitantes': atividade.capacidadeVisitantes,
          'duracaoSecao': atividade.duracaoSecao,
        });
      }

      await _dio.put('/atividades/$id', data: payload);
    } catch (e) {
      throw 'Erro ao atualizar atividade: $e';
    }
  }

  Future<void> deleteAtividade(int id) async {
    try {
      await _dio.delete('/atividades/$id');
    } catch (e) {
      throw 'Erro ao deletar atividade: $e';
    }
  }
}
