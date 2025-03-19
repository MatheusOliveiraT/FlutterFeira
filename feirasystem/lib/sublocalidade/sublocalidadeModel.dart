// ignore_for_file: file_names

import 'package:feirasystem/localidade/localidadeModel.dart';

class Sublocalidade {
  final int? id;
  final String nome;
  final String descricao;
  final Localidade localidade;

  Sublocalidade(
    this.id,
    this.nome,
    this.descricao,
    this.localidade,
  );

  @override
  String toString() {
    return 'Sublocalidade{\nnome: $nome, \ndescrição: $descricao, \nlocalidade: $localidade\n}';
  }
}
