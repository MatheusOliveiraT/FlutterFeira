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
}

class AgendamentoFeira {
  final int id;
  final DateTime data;
  final Turno turno;
  final Feira feira;

  AgendamentoFeira(this.id, this.data, this.turno, this.feira);

  @override
  String toString() {
    return 'AgendamentoFeira {\nid: $id, \ndata: $data, \nturno: $turno, \nfeira: $feira\n}';
  }
}
