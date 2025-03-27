import 'package:flutter/material.dart';
// import 'package:feirasystem/pessoa/monitor/monitorModel.dart';

class Monitores extends StatefulWidget{
  const Monitores({super.key});
  @override
  _MonitoresState createState() => _MonitoresState();
}

class _MonitoresState extends State<Monitores> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorCelular = TextEditingController();
  final TextEditingController _controladorEmail = TextEditingController();
  final TextEditingController _controladorRa = TextEditingController();

  bool _validarForm() {
    String nome = _controladorNome.text.trim();
    String celular = _controladorCelular.text.trim();
    String email = _controladorEmail.text.trim();
    String ra = _controladorRa.text.trim();

    if(nome.isEmpty || celular.isEmpty || email.isEmpty || ra.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos obrigatórios!'),
          duration: Duration(seconds: 1),
        )
      );
      return false;
    }
    return true;
  }

  bool _cadastroSucesso() {
    if(_validarForm()){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cadastrado com sucesso!'),
          duration: Duration(seconds: 1),
        )
      );
    return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastre-se '),
    ),
    body: Padding(
      padding: const EdgeInsets.all((16.0)),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              autofocus: true,
              controller: _controladorNome,
              decoration: InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.yellow),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _controladorRa,
              decoration: InputDecoration(
                labelText: 'RA',
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.yellow),
                )
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _controladorCelular,
              decoration: InputDecoration(
                labelText: 'Celular',
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.yellow),
                )
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _controladorEmail,
              decoration: InputDecoration(
                labelText: 'Email',
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.yellow),
                )
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: (){
                _cadastroSucesso();
              },
              child: const Text('Cadastrar'),
            )
          ],
        ),
      ),
    ),
    );
  }
}
