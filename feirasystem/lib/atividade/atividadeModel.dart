// ========= ENUMS =========

enum TipoAtividade { SUBLOCALIDADE, LOCALIDADE }

extension TipoAtividadeExtensao on TipoAtividade {
  static TipoAtividade fromString(String value) {
    switch (value.toUpperCase()) {
      case 'SUBLOCALIDADE':
        return TipoAtividade.SUBLOCALIDADE;
      case 'LOCALIDADE':
        return TipoAtividade.LOCALIDADE;
      default:
        throw ArgumentError('TipoAtividade inválido: $value');
    }
  }

  String get descricao {
    switch (this) {
      case TipoAtividade.SUBLOCALIDADE:
        return 'SUBLOCALIDADE';
      case TipoAtividade.LOCALIDADE:
        return 'LOCALIDADE';
    }
  }
}

// -------------------------

enum Tipo { SECAO, CONTINUO }

extension TipoExtensao on Tipo {
  static Tipo fromString(String value) {
    switch (value.toUpperCase()) {
      case 'SECAO':
        return Tipo.SECAO;
      case 'CONTINUO':
        return Tipo.CONTINUO;
      default:
        throw ArgumentError('Tipo inválido: $value');
    }
  }

  String get descricao {
    switch (this) {
      case Tipo.SECAO:
        return 'SECAO';
      case Tipo.CONTINUO:
        return 'CONTINUO';
    }
  }
}

// -------------------------

enum Status { OCUPADA, OCIOSA, INATIVA }

extension StatusExtensao on Status {
  static Status fromString(String value) {
    switch (value.toUpperCase()) {
      case 'OCUPADA':
        return Status.OCUPADA;
      case 'OCIOSA':
        return Status.OCIOSA;
      case 'INATIVA':
        return Status.INATIVA;
      default:
        throw ArgumentError('Status inválido: $value');
    }
  }

  String get descricao {
    switch (this) {
      case Status.OCUPADA:
        return 'OCUPADA';
      case Status.OCIOSA:
        return 'OCIOSA';
      case Status.INATIVA:
        return 'INATIVA';
    }
  }
}

// ========= MODEL =========

class Atividade {
  final int? id;
  final String nome;
  final String descricao;
  final int quantidadeMonitores;

  final TipoAtividade tipoAtividade;

  final Tipo? tipo;
  final Status? status;

  final int? duracaoSecao;
  final int? capacidadeVisitantes;

  final int idFeira;
  final int idProfessor;

  final int? idLocalidade;
  final int? idSublocalidade;

  bool inscrito;

  Atividade({
    this.id,
    required this.nome,
    required this.descricao,
    required this.quantidadeMonitores,
    required this.tipoAtividade,
    required this.idFeira,
    required this.idProfessor,
    this.tipo,
    this.status,
    this.duracaoSecao,
    this.capacidadeVisitantes,
    this.idLocalidade,
    this.idSublocalidade,
    this.inscrito = false,
  });

  factory Atividade.fromJson(Map<String, dynamic> json) {
    return Atividade(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
      quantidadeMonitores:
          json['quantidadeMonitores'] ?? json['qtdMonitores'],
      duracaoSecao: json['duracaoSecao'] ?? 0,
      capacidadeVisitantes: json['capacidadeVisitantes'] ?? 0,
      tipoAtividade:
          TipoAtividadeExtensao.fromString(json['tipoAtividade']),
      tipo: json['tipo'] != null
          ? TipoExtensao.fromString(json['tipo'])
          : Tipo.SECAO,
      status: json['status'] != null
          ? StatusExtensao.fromString(json['status'])
          : Status.OCIOSA,
      idFeira: json['idFeira'] ?? json['feira'],
      idProfessor: json['idProfessor'] ?? json['professor'],
      idLocalidade: json['idLocalidade'] ?? json['localidade'],
      idSublocalidade: json['idSublocalidade'] ?? json['sublocalidade'],
    );
  }

}
