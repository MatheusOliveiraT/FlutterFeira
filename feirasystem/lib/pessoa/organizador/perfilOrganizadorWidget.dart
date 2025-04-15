import 'package:flutter/material.dart';
// import 'package:feirasystem/pessoa/organizador/organizadorWidget.dart';

class PerfilOrganizadores extends StatefulWidget{
  const PerfilOrganizadores({super.key});
  @override
  _PerfilOrganizadoresState createState() => _PerfilOrganizadoresState();
}

class _PerfilOrganizadoresState extends State<PerfilOrganizadores> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(  
        title: const Text('Meu Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all((16.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/perfil.png'),
            ),
            const SizedBox(height: 12),
            const Card(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                title: Text('Fulaninho'),
                subtitle: Text('Nome'),
              )
            ),
            const SizedBox(height: 12),
            const Card(             
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                title: Text('fulano32@gmail.com',
                ),
              )
            ),
            const SizedBox(height: 12),
            const Card(             
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                title: Text('(98) 98888-6666'),
                subtitle: Text('Celular'),
              )
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Editar')), 
                );
              },
              label: const Text('Editar'),
              icon: const Icon(Icons.edit),
            )
          ],
          ) 
        )
    );
  }
}