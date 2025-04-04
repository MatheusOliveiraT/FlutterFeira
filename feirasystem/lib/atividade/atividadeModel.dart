class Atividade {
  final int? id;
  final String nome;
  final String descricao;
  final int quantidadeMonitores;
  final int idFeira;
  final int idProfessor;

  Atividade({
    this.id,
    required this.nome,
    required this.descricao,
    required this.quantidadeMonitores,
    required this.idFeira,
    required this.idProfessor,
  });

  @override
  String toString() {
    return 'Atividade {\nid: $id, \nnome: $nome, \ndescricao: $descricao, \nquantidadeMonitores: $quantidadeMonitores, \nidFeira: $idFeira, \nidProfessor: $idProfessor\n}';
  }
}

class AtividadeLocalidade extends Atividade {
  final int idLocalidade;

  AtividadeLocalidade(
      {super.id,
      required super.nome,
      required super.descricao,
      required super.quantidadeMonitores,
      required this.idLocalidade,
      required super.idFeira,
      required super.idProfessor});

  @override
  String toString() {
    return 'Atividade {\nid: $id, \nnome: $nome, \ndescricao: $descricao, \nquantidadeMonitores: $quantidadeMonitores, \nidFeira: $idFeira, \nidProfessor: $idProfessor, \nidLocalidade: $idLocalidade\n}';
  }

  factory AtividadeLocalidade.fromJson(Map<String, dynamic> json) {
    return AtividadeLocalidade(
      id: int.parse(json['id'].toString()),
      nome: json['nome'],
      descricao: json['descricao'],
      quantidadeMonitores: int.parse(json['quantidadeMonitores'].toString()),
      idLocalidade: int.parse(json['idLocalidade'].toString()),
      idProfessor: int.parse(json['idProfessor'].toString()),
      idFeira: int.parse(json['idFeira'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'descricao': descricao,
      'quantidadeMontiroes': quantidadeMonitores,
      'idLocalidade': idLocalidade,
      'idProfessor': idProfessor,
      'idFeira': idFeira,
    };
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

class AtividadeSublocalidade extends Atividade {
  final int idSublocalidade;
  final Tipo tipo;
  final int duracaoSecao;
  final int capacidadeVisitantes;
  final Status status;

  AtividadeSublocalidade(
      {super.id,
      required super.nome,
      required super.descricao,
      required super.quantidadeMonitores,
      required this.idSublocalidade,
      required this.tipo,
      required this.duracaoSecao,
      required this.capacidadeVisitantes,
      required this.status,
      required super.idFeira,
      required super.idProfessor});

  @override
  String toString() {
    return 'Atividade {\nid: $id, \nnome: $nome, \ndescricao: $descricao, \nquantidadeMonitores: $quantidadeMonitores, \nidFeira: $idFeira, \nidProfessor: $idProfessor, \nidSublocalidade: $idSublocalidade, \ntipo: $tipo, \nduracaoSecao: $duracaoSecao, \ncapacidadeVisitantes: $capacidadeVisitantes, \nstatus: $status\n}';
  }

  factory AtividadeSublocalidade.fromJson(Map<String, dynamic> json) {
    return AtividadeSublocalidade(
      id: int.parse(json['id'].toString()),
      nome: json['nome'],
      descricao: json['descricao'],
      quantidadeMonitores: int.parse(json['quantidadeMonitores'].toString()),
      duracaoSecao: int.parse(json['duracao'].toString()),
      capacidadeVisitantes: int.parse(json['capacidadeVisitante'].toString()),
      idSublocalidade: int.parse(json['idSublocalidade'].toString()),
      idProfessor: int.parse(json['idProfessor'].toString()),
      idFeira: int.parse(json['idFeira'].toString()),
      status: StatusExtensao.fromString(json['status']),
      tipo: TipoExtensao.fromString(json['tipo']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'descricao': descricao,
      'quantidadeMontiroes': quantidadeMonitores,
      'duracao': duracaoSecao,
      'capacidadeVisitante': capacidadeVisitantes,
      'idSublocalidade': idSublocalidade,
      'idProfessor': idProfessor,
      'idFeira': idFeira,
      'status': status.descricao,
      'tipo': tipo.descricao,
    };
  }
}
