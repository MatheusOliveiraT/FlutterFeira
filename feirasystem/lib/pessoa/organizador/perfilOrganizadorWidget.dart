import 'package:feirasystem/assets/bottomAppBarOrganizador.dart';
import 'package:feirasystem/assets/customSnackBar.dart';
import 'package:flutter/material.dart';

class PerfilOrganizadores extends StatefulWidget {
  const PerfilOrganizadores({super.key});
  @override
  _PerfilOrganizadoresState createState() => _PerfilOrganizadoresState();
}

class _PerfilOrganizadoresState extends State<PerfilOrganizadores> {
  Future<void> _deleteConta() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir sua conta'),
        content: const Text(
            'Você tem certeza que quer excluir a sua conta? Esta ação é irreversível!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      // TO DO
      Navigator.pushNamedAndRemoveUntil(
          context, 'usuario', (Route<dynamic> route) => false);
      showCustomSnackBar(context, 'Sua conta foi excluída com sucesso.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Center(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all((16.0)),
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 400,
                    minWidth: 200,
                  ),
                  child: const Card(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: ListTile(
                        title: Text('Fulaninho'),
                        subtitle: Text('Nome'),
                      )),
                ),
                const SizedBox(height: 16),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 400,
                    minWidth: 200,
                  ),
                  child: const Card(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: ListTile(
                        title: Text(
                          'fulano32@gmail.com',
                        ),
                        subtitle: Text('E-mail'),
                      )),
                ),
                const SizedBox(height: 16),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 400,
                    minWidth: 200,
                  ),
                  child: const Card(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: ListTile(
                        title: Text('(98) 98888-6666'),
                        subtitle: Text('Celular'),
                      )),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {},
                  label: const Text('Editar seus dados'),
                  icon: const Icon(Icons.edit),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    _deleteConta();
                  },
                  label: const Text('Excluir sua conta'),
                  icon: const Icon(Icons.delete),
                )
              ],
            )),
      )),
      bottomNavigationBar: const BottomAppBarOrganizador(),
    );
  }
}
