import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:feirasystem/agendamentoFeira/agendamentoFeiraModel.dart';
import 'package:feirasystem/agendamentoFeira/agendamentoFeiraService.dart';
import 'agendamentoFeiraService_test.mocks.dart';

// por enquanto os testes não funcionam com o interceptor

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late AgendamentoFeiraService agendamentoService;

  setUp(() {
    mockDio = MockDio();
    agendamentoService = AgendamentoFeiraService(mockDio);
  });

  group('AgendamentoFeiraService', () {
    test(
        'deve retornar uma lista de agendamentos quando a requisição for bem-sucedida',
        () async {
      final mockResponse = {
        'data': [
          {
            'id': 1,
            'attributes': {
              'data': '2025-03-21T12:00:00.000Z',
              'turno': 'Manhã',
              'idFeira': 1
            }
          },
          {
            'id': 2,
            'attributes': {
              'data': '2025-03-22T15:00:00.000Z',
              'turno': 'Tarde',
              'idFeira': 2
            }
          }
        ]
      };

      when(mockDio.get('/agendamentoFeiras')).thenAnswer(
        (_) async => Response(
          data: mockResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/agendamentoFeiras'),
        ),
      );

      final agendamentos = await agendamentoService.getAgendamentos();

      expect(agendamentos, isA<List<AgendamentoFeira>>());
      expect(agendamentos.length, 2);
    });

    test('deve lançar uma exceção quando a requisição falhar', () async {
      when(mockDio.get('/agendamentoFeiras')).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/agendamentoFeiras'),
        error: 'Erro de conexão',
      ));

      expect(() async => await agendamentoService.getAgendamentos(),
          throwsA(isA<String>()));
    });

    test(
        'deve retornar um agendamento específico quando a requisição for bem-sucedida',
        () async {
      final mockResponse = {
        'data': {
          'id': 1,
          'attributes': {
            'data': '2025-03-21T12:00:00.000Z',
            'turno': 'Manhã',
            'idFeira': 1
          }
        }
      };

      when(mockDio.get('/agendamentoFeiras/1')).thenAnswer(
        (_) async => Response(
          data: mockResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/agendamentoFeiras/1'),
        ),
      );

      final agendamento = await agendamentoService.getAgendamento(1);
      expect(agendamento, isA<AgendamentoFeira>());
    });

    test('deve criar um agendamento com sucesso', () async {
      final agendamento = AgendamentoFeira(
          id: 1,
          data: DateTime.parse('2025-03-21T12:00:00.000Z'),
          turno: Turno.MANHA,
          idFeira: 1);
      final mockResponse = {
        'data': {
          'id': 1,
          'attributes': {
            'data': '2025-03-21T12:00:00.000Z',
            'turno': 'Manhã',
            'idFeira': 1
          }
        }
      };

      when(mockDio.post('/agendamentoFeiras', data: anyNamed('data')))
          .thenAnswer(
        (_) async => Response(
          data: mockResponse,
          statusCode: 201,
          requestOptions: RequestOptions(path: '/agendamentoFeiras'),
        ),
      );

      final createdAgendamento =
          await agendamentoService.createAgendamento(agendamento);
      expect(createdAgendamento.id, 1);
    });

    test('deve atualizar um agendamento com sucesso', () async {
      final agendamento = AgendamentoFeira(
          id: 1,
          data: DateTime.parse('2025-03-21T12:00:00.000Z'),
          turno: Turno.NOITE,
          idFeira: 1);
      final mockResponse = {
        'data': {
          'id': 1,
          'attributes': {
            'data': '2025-03-21T12:00:00.000Z',
            'turno': 'Noite',
            'idFeira': 1
          }
        }
      };

      when(mockDio.put('/agendamentoFeiras/1', data: anyNamed('data')))
          .thenAnswer(
        (_) async => Response(
          data: mockResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/agendamentoFeiras/1'),
        ),
      );

      await agendamentoService.updateAgendamento(1, agendamento);
    });

    test('deve deletar um agendamento com sucesso', () async {
      when(mockDio.delete('/agendamentoFeira/1')).thenAnswer(
        (_) async => Response(
          statusCode: 204,
          requestOptions: RequestOptions(path: '/agendamentoFeira/1'),
        ),
      );

      await agendamentoService.deleteAgendamento(1);
      verify(mockDio.delete('/agendamentoFeira/1')).called(1);
    });
  });
}
