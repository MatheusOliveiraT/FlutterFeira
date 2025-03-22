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
      case 'manhã':
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
  final DateTime data;
  final Turno turno;
  final int idFeira;

  AgendamentoFeira(
      {this.id,
      required this.data,
      required this.turno,
      required this.idFeira});

  @override
  String toString() {
    return 'AgendamentoFeira {\nid: $id, \ndata: $data, \nturno: $turno, \nfeira: $idFeira\n}';
  }

  factory AgendamentoFeira.fromJson(Map<String, dynamic> json) {
    if (json['attributes'] != null) {
      final attributes = json['attributes'];
      return AgendamentoFeira(
        id: json['id'],
        data: DateTime.parse(attributes['data']),
        turno: TurnoExtensao.fromString(attributes['turno']),
        idFeira: attributes['idFeira'],
      );
    }
    return AgendamentoFeira(
      id: int.parse(json['id'].toString()),
      data: DateTime.parse(json['data']),
      turno: TurnoExtensao.fromString(json['turno']),
      idFeira: json['idFeira'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toIso8601String(),
      'turno': turno.descricao,
      'idFeira': idFeira,
    };
  }
}
