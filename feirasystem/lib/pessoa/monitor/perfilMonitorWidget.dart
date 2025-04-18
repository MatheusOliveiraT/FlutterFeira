import 'package:flutter/material.dart';

class PerfilMonitores extends StatefulWidget {
  const PerfilMonitores({super.key});
  @override
  _PerfilMonitoresState createState() => _PerfilMonitoresState();
}

class _PerfilMonitoresState extends State<PerfilMonitores> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/perfil.png"),
              ),
              const SizedBox(width: 16),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Fulano da Silva",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(width: 16),
                  Text('dasilva-fi@email.com'),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Editar')),
                  );
                },
                child: const Text('Editar'),
              )
            ],
          )),
    );
  }
}
