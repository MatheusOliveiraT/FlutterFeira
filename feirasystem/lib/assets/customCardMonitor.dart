import 'package:flutter/material.dart';

class CustomCardMonitor extends StatelessWidget {
  final String titulo;
  final String duracao;
  final String local;
  final String descricao;
  final num quantidadeMonitores;
  final VoidCallback? onInscrever;
  final bool inscrito;

  const CustomCardMonitor({
    super.key,
    required this.titulo,
    required this.duracao,
    required this.local,
    required this.descricao,
    required this.quantidadeMonitores,
    this.onInscrever,
    this.inscrito = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('Duração: $duracao', style: TextStyle(color: Colors.grey[700])),
            Text('Local: $local', style: TextStyle(color: Colors.grey[700])),
            Text('Descrição: $descricao', style: TextStyle(color: Colors.grey[700])),
            Text('Quantidade de monitores: $quantidadeMonitores', style: TextStyle(color: Colors.grey[700])),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: inscrito ? null : onInscrever,
                icon: Icon(
                  inscrito
                      ? Icons.check_circle
                      : Icons.check_circle_outline,
                ),
                label: Text(inscrito ? 'Inscrito' : 'Inscrever-se'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
