import 'package:feirasystem/feira/feiraModel.dart';

enum Turno { MANHA, TARDE, NOITE }

extension TurnoExtensao on Turno {
  String get descricao {
    switch (this) {
      case Turno.MANHA:
        return "Manhã";
      case Turno.TARDE:
        return "Tarde";
      case Turno.NOITE:
        return "Noite";
    }
  }

  static Turno fromString(String turno) {
    switch (turno.toLowerCase()) {
      case 'manha':
        return Turno.MANHA;
      case 'tarde':
        return Turno.TARDE;
      case 'noite':
        return Turno.NOITE;
      default:
        throw ArgumentError('Turno inválido');
    }
  }
}

class AgendamentoFeira {
  final int? id;
  final String? documentId;
  final DateTime data;
  final Turno turno;
  final Feira feira;

  AgendamentoFeira(
      {this.id,
      this.documentId,
      required this.data,
      required this.turno,
      required this.feira});

  @override
  String toString() {
    return 'AgendamentoFeira {\nid: $id, \ndata: $data, \nturno: $turno, \nfeira: $feira\n}';
  }

  factory AgendamentoFeira.fromJson(Map<String, dynamic> json) {
    if (json['attributes'] != null) {
      final attributes = json['attributes'];
      final feira = Feira.fromJson(attributes['feira']);
      return AgendamentoFeira(
        id: json['id'],
        documentId: attributes['documentId'],
        data: DateTime.parse(attributes['data']),
        turno: TurnoExtensao.fromString(attributes['turno']),
        feira: feira,
      );
    }
    final feira = Feira.fromJson(json['feira']);
    return AgendamentoFeira(
      id: int.parse(json['id'].toString()),
      documentId: json['documentId'],
      data: DateTime.parse(json['data']),
      turno: TurnoExtensao.fromString(json['turno']),
      feira: feira,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toIso8601String(),
      'turno': turno.descricao,
      'feira': feira.toJson(),
    };
  }
}
