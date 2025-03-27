import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:feirasystem/feira/feiraModel.dart';
import 'package:feirasystem/feira/feiraService.dart';
import 'feiraService_test.mocks.dart';

// por enquanto os testes não funcionam com o interceptor

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late FeiraService feiraService;

  setUp(() {
    mockDio = MockDio();
    feiraService = FeiraService(mockDio);
  });

  group('FeiraService', () {
    test(
        'deve retornar uma lista de feiras quando a requisição for bem-sucedida',
        () async {
      final mockResponse = {
        'data': [
          {
            'id': 1,
            'attributes': {'nome': 'Feira Orgânica'}
          },
          {
            'id': 2,
            'attributes': {'nome': 'Feira Artesanal'}
          }
        ]
      };

      when(mockDio.get('/feira')).thenAnswer(
        (_) async => Response(
          data: mockResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/feira'),
        ),
      );

      final feiras = await feiraService.getFeiras();

      expect(feiras, isA<List<Feira>>());
      expect(feiras.length, 2);
      expect(feiras[0].nome, 'Feira Orgânica');
      expect(feiras[1].nome, 'Feira Artesanal');
    });

    test('deve lançar uma exceção quando a requisição falhar', () async {
      when(mockDio.get('/feira')).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/feira'),
        error: 'Erro de conexão',
      ));

      expect(
          () async => await feiraService.getFeiras(), throwsA(isA<String>()));
    });

    test(
        'deve retornar uma feira quando a requisição de getFeira for bem-sucedida',
        () async {
      final mockResponse = {
        'data': {
          'id': 1,
          'attributes': {'nome': 'Feira Orgânica'}
        }
      };

      when(mockDio.get('/feira/1')).thenAnswer(
        (_) async => Response(
          data: mockResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/feira/1'),
        ),
      );

      final feira = await feiraService.getFeira(1);

      expect(feira, isA<Feira>());
      expect(feira.nome, 'Feira Orgânica');
    });

    test('deve criar uma feira com sucesso', () async {
      final feira = Feira(id: 1, nome: 'Feira Nova');
      final mockResponse = {
        'data': {
          'id': 1,
          'attributes': {'nome': 'Feira Nova'}
        }
      };

      when(mockDio.post('/feira', data: anyNamed('data'))).thenAnswer(
        (_) async => Response(
          data: mockResponse,
          statusCode: 201,
          requestOptions: RequestOptions(path: '/feira'),
        ),
      );

      final createdFeira = await feiraService.createFeira(feira);
      expect(createdFeira.nome, 'Feira Nova');
    });

    test('deve atualizar uma feira com sucesso', () async {
      final feira = Feira(id: 1, nome: 'Feira Atualizada');
      final mockResponse = {
        'data': {
          'id': 1,
          'attributes': {'nome': 'Feira Atualizada'}
        }
      };

      when(mockDio.put('/feira/1', data: anyNamed('data'))).thenAnswer(
        (_) async => Response(
          data: mockResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/feira/1'),
        ),
      );

      final updatedFeira = await feiraService.updateFeira(1, feira);
      expect(updatedFeira.nome, 'Feira Atualizada');
    });

    test('deve deletar uma feira com sucesso', () async {
      when(mockDio.delete('/feira/1')).thenAnswer(
        (_) async => Response(
          statusCode: 204,
          requestOptions: RequestOptions(path: '/feira/1'),
        ),
      );

      await feiraService.deleteFeira(1);
      verify(mockDio.delete('/feira/1')).called(1);
    });
  });
}
