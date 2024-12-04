import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomePage',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 0, 81, 255)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Tela Inicial'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Cadastro()),
            );
          },
          child: const Text('Cadastros'),
        ),
      ),
    );
  }
}

class Cadastro extends StatelessWidget {
  const Cadastro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Cadastro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Localidades()),
                );
              },
              child: const Text('Localidades'),
            ),
            const SizedBox(height: 20), // Espaçamento entre os botões
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Sublocalidades()),
                );
              },
              child: const Text('Sublocalidades'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Atividades()),
                );
              },
              child: const Text('Atividades'),
            ),
          ],
        ),
      ),
    );
  }
}

class Localidade {
  final String nome;
  final int quantidadeSalas;

  Localidade(
    this.nome,
    this.quantidadeSalas,
  );

  @override
  String toString() {
    return 'Localidade{nome: $nome, quantidadeSalas: $quantidadeSalas';
  }
}

class Localidades extends StatelessWidget {
  Localidades({super.key});

  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorQuantidadeSalas =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('SubLocalidades'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controladorNome,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: _controladorQuantidadeSalas,
                decoration:
                    const InputDecoration(labelText: 'Quantidade de Salas'),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                child: const Text('Cadastrar'),
                onPressed: () {
                  final String nome = _controladorNome.text;
                  final int? quantidadeSalas =
                      int.tryParse(_controladorQuantidadeSalas.text);

                  final Localidade localidadeNovo =
                      Localidade(nome, quantidadeSalas!);
                  // ignore: avoid_print
                  print(localidadeNovo);
                  final snackBar = SnackBar(
                    content: const Text('Localidade criada com sucesso!'),
                    duration: const Duration(seconds: 2), // Duração da mensagem
                    action: SnackBarAction(
                      label: 'Desfazer',
                      onPressed: () {
                        // Ação ao clicar no botão do SnackBar
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Sublocalidade {
  final String nome;
  final String localidade;

  Sublocalidade(
    this.nome,
    this.localidade,
  );

  @override
  String toString() {
    return 'Sublocalidade{nome: $nome, localidade: $localidade}';
  }
}

class Sublocalidades extends StatelessWidget {
  Sublocalidades({super.key});

  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorLocalidade = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Sublocalidades'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controladorNome,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: _controladorLocalidade,
                decoration: const InputDecoration(labelText: 'Localidade'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                child: const Text('Cadastrar'),
                onPressed: () {
                  final String nome = _controladorNome.text;
                  final String localidade = _controladorLocalidade.text;

                  final Sublocalidade subLocalidadeNovo =
                      Sublocalidade(nome, localidade);
                  // ignore: avoid_print
                  print(subLocalidadeNovo);
                  final snackBar = SnackBar(
                    content: const Text('Sublocalidade criada com sucesso!'),
                    duration: const Duration(seconds: 2), // Duração da mensagem
                    action: SnackBarAction(
                      label: 'Desfazer',
                      onPressed: () {
                        // Ação ao clicar no botão do SnackBar
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

class Atividades extends StatelessWidget {
  Atividades({super.key});

  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorSublocalidade =
      TextEditingController();
  final TextEditingController _controladorQuantidadeMonitores =
      TextEditingController();
  final TextEditingController _controladorTipo = TextEditingController();
  final TextEditingController _controladorDuracaoSecao =
      TextEditingController();
  final TextEditingController _controladorCapacidadeVisitantes =
      TextEditingController();
  final TextEditingController _controladorStatus = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Atividades'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controladorNome,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: _controladorSublocalidade,
                decoration: const InputDecoration(labelText: 'Subocalidade'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: _controladorQuantidadeMonitores,
                decoration:
                    const InputDecoration(labelText: 'Quantidade de Monitores'),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: _controladorTipo,
                decoration: const InputDecoration(labelText: 'Tipo'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: _controladorDuracaoSecao,
                decoration:
                    const InputDecoration(labelText: 'Duração da Seção'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: _controladorCapacidadeVisitantes,
                decoration: const InputDecoration(
                    labelText: 'Capacidade de Visitantes'),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: _controladorStatus,
                decoration: const InputDecoration(labelText: 'Status'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                child: const Text('Cadastrar'),
                onPressed: () {
                  final String nome = _controladorNome.text;
                  final String localidade = _controladorSublocalidade.text;
                  final int? quantidadeMonitores =
                      int.tryParse(_controladorQuantidadeMonitores.text);
                  final String tipo = _controladorTipo.text;
                  final String duracaoSecao = _controladorDuracaoSecao.text;
                  final int? capacidadeVisitantes =
                      int.tryParse(_controladorCapacidadeVisitantes.text);
                  final String status = _controladorStatus.text;

                  final Atividade atividadeNovo = Atividade(
                      nome,
                      localidade,
                      quantidadeMonitores!,
                      tipo,
                      duracaoSecao,
                      capacidadeVisitantes!,
                      status);
                  // ignore: avoid_print
                  print(atividadeNovo);
                  final snackBar = SnackBar(
                    content: const Text('Atividade criada com sucesso!'),
                    duration: const Duration(seconds: 2), // Duração da mensagem
                    action: SnackBarAction(
                      label: 'Desfazer',
                      onPressed: () {
                        // Ação ao clicar no botão do SnackBar
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
