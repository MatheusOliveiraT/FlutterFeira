// ignore_for_file: file_names

class Atividade {
  final String nome;
  final String sublocalidade;
  final int quantidadeMonitores;
  final String tipo;
  final String duracaoSecao;
  final int capacidadeVisitantes;
  final String status;

  Atividade(
    this.nome,
    this.sublocalidade,
    this.quantidadeMonitores,
    this.tipo,
    this.duracaoSecao,
    this.capacidadeVisitantes,
    this.status,
  );

  @override
  String toString() {
    return 'Atividade{nome: $nome, sublocalidade: $sublocalidade, quantidadeMonitores: $quantidadeMonitores, tipo: $tipo, duracaoSecao: $duracaoSecao, capacidadeVisitantes: $capacidadeVisitantes, status: $status}';
  }
}
