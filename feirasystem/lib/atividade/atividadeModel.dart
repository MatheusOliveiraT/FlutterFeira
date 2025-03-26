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
    return 'Atividade{\nid: $id, \nnome: $nome, \ndescricao: $descricao, \nquantidadeMonitores: $quantidadeMonitores, \nidFeira: $idFeira, \nidProfessor: $idProfessor\n}';
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
    return 'Atividade{\nid: $id, \nnome: $nome, \ndescricao: $descricao, \nquantidadeMonitores: $quantidadeMonitores, \nidFeira: $idFeira, \nidProfessor: $idProfessor, \nidLocalidade: $idLocalidade\n}';
  }
}

enum Tipo { SECAO, CONTINUO }

enum Status { OCUPADA, OCIOSA, INATIVA }

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
    return 'Atividade{\nid: $id, \nnome: $nome, \ndescricao: $descricao, \nquantidadeMonitores: $quantidadeMonitores, \nidFeira: $idFeira, \nidProfessor: $idProfessor, \nidSublocalidade: $idSublocalidade, \ntipo: $tipo, \nduracaoSecao: $duracaoSecao, \ncapacidadeVisitantes: $capacidadeVisitantes, \nstatus: $status\n}';
  }
}
