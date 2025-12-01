enum TipoAtividade { SUBLOCALIDADE, LOCALIDADE }

extension TipoAtividadeExtensao on TipoAtividade {
  String get descricao {
    switch (this) {
      case TipoAtividade.SUBLOCALIDADE:
        return "Sublocalidade";
      case TipoAtividade.LOCALIDADE:
        return "Localidade";
    }
  }

  static TipoAtividade fromString(String tipoAtividade) {
    switch (tipoAtividade.toLowerCase()) {
      case 'sublocalidade':
        return TipoAtividade.SUBLOCALIDADE;
      case 'localidade':
        return TipoAtividade.LOCALIDADE;
      default:
        throw ArgumentError('Tipo atividade inválido');
    }
  }
}

enum Tipo { SECAO, CONTINUO }

extension TipoExtensao on Tipo {
  String get descricao {
    switch (this) {
      case Tipo.SECAO:
        return "Seção";
      case Tipo.CONTINUO:
        return "Contínuo";
    }
  }

  static Tipo fromString(String tipo) {
    switch (tipo.toLowerCase()) {
      case 'seção':
        return Tipo.SECAO;
      case 'contínuo':
        return Tipo.CONTINUO;
      default:
        throw ArgumentError('Tipo inválido');
    }
  }
}

enum Status { OCUPADA, OCIOSA, INATIVA }

extension StatusExtensao on Status {
  String get descricao {
    switch (this) {
      case Status.OCUPADA:
        return "Ocupada";
      case Status.OCIOSA:
        return "Ociosa";
      case Status.INATIVA:
        return "Inativa";
    }
  }

  static Status fromString(String status) {
    switch (status.toLowerCase()) {
      case 'ocupada':
        return Status.OCUPADA;
      case 'ociosa':
        return Status.OCIOSA;
      case 'inativa':
        return Status.INATIVA;
      default:
        throw ArgumentError('Status inválido');
    }
  }
}

class Atividade {
  final int? id;
  final String nome;
  final String descricao;
  final int quantidadeMonitores;
  final int idFeira;
  final int idProfessor;
  final TipoAtividade tipoAtividade;
  final Tipo? tipo;
  final int? duracaoSecao;
  final int? capacidadeVisitantes;
  final Status? status;
  final int? idLocalidade;
  final int? idSublocalidade;
  bool inscrito;

  Atividade({
    this.id,
    required this.nome,
    required this.descricao,
    required this.quantidadeMonitores,
    required this.idFeira,
    required this.idProfessor,
    required this.tipoAtividade,
    this.tipo,
    this.duracaoSecao,
    this.capacidadeVisitantes,
    this.status,
    this.idLocalidade,
    this.idSublocalidade,
    this.inscrito = false,
  });

  factory Atividade.fromJson(Map<String, dynamic> json) {
    return Atividade(
      id: int.parse(json['id'].toString()),
      nome: json['nome'],
      descricao: json['descricao'],
      quantidadeMonitores: int.parse(json['quantidadeMonitores'].toString()),
      tipoAtividade: TipoAtividadeExtensao.fromString(json['tipoAtividade']),
      duracaoSecao: int.parse(json['duracao'].toString()),
      capacidadeVisitantes: int.parse(json['capacidadeVisitante'].toString()),
      idLocalidade: int.parse(json['idLocalidade'].toString()),
      idSublocalidade: int.parse(json['idSublocalidade'].toString()),
      idProfessor: int.parse(json['idProfessor'].toString()),
      idFeira: int.parse(json['idFeira'].toString()),
      status: StatusExtensao.fromString(json['status']),
      tipo: TipoExtensao.fromString(json['tipo']),
    );
  }

  Map<String, dynamic> toJson() {
    if (tipoAtividade == TipoAtividade.LOCALIDADE) {
      return {
        'nome': nome,
        'descricao': descricao,
        'quantidadeMontiroes': quantidadeMonitores,
        'idLocalidade': idLocalidade,
        'idProfessor': idProfessor,
        'idFeira': idFeira,
        'tipoAtividade': tipoAtividade.descricao,
      };
    }
    return {
      'nome': nome,
      'descricao': descricao,
      'quantidadeMontiroes': quantidadeMonitores,
      'idProfessor': idProfessor,
      'idFeira': idFeira,
      'idSublocalidade': idSublocalidade,
      'duracao': duracaoSecao,
      'capacidadeVisitante': capacidadeVisitantes,
      'status': status!.descricao,
      'tipo': tipo!.descricao,
      'tipoAtividade': tipoAtividade.descricao,
    };
  }
}
