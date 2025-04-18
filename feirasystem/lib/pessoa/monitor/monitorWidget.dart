import 'package:flutter/material.dart';
import 'package:feirasystem/assets/formFields/passwordField.dart';
import 'package:feirasystem/assets/formFields/phoneField.dart';

class Monitores extends StatefulWidget {
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
  final TextEditingController _controladorSenha = TextEditingController();
  final TextEditingController _controladorCSenha = TextEditingController();

  void _mostrarSnackBar(String message, int tempo) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: tempo),
      ),
    );
  }

  bool _validarForm() {
    String nome = _controladorNome.text.trim();
    String celular = _controladorCelular.text.trim();
    String email = _controladorEmail.text.trim();
    String ra = _controladorRa.text.trim();
    String senha = _controladorSenha.text.trim();
    String csenha = _controladorCSenha.text.trim();

    if (nome.isEmpty ||
        celular.isEmpty ||
        email.isEmpty ||
        ra.isEmpty ||
        senha.isEmpty ||
        csenha.isEmpty) {
      _mostrarSnackBar('Preencha todos os campos obrigatórios!', 1);
      return false;
    }
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(email)) {
      _mostrarSnackBar('E-mail inválido.', 1);
      return false;
    }
    if (senha != csenha) {
      _mostrarSnackBar('Senhas digitadas não correspondem!', 1);
      return false;
    }
    if (senha.length < 8) {
      _mostrarSnackBar(
          'Senha muito curta! Sua senha deve ter pelo menos 8 dígitos.', 2);
      return false;
    }
    return true;
  }

  bool _cadastroSucesso() {
    if (_validarForm()) {
      _mostrarSnackBar('Cadastrado com sucesso!', 2);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastre-se'),
      ),
      backgroundColor: const Color.fromARGB(255, 236, 239, 243),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Cadastre-se como monitor',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 400,
                      minWidth: 200,
                    ),
                    child: TextFormField(
                      autofocus: true,
                      controller: _controladorNome,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 400,
                      minWidth: 200,
                    ),
                    child: TextFormField(
                      controller: _controladorRa,
                      decoration: const InputDecoration(
                        labelText: 'Registro Acadêmico (RA)',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 400,
                      minWidth: 200,
                    ),
                    child: PhoneField(controller: _controladorCelular),
                  ),
                  const SizedBox(height: 16),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 400,
                      minWidth: 200,
                    ),
                    child: TextFormField(
                      controller: _controladorEmail,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 400,
                      minWidth: 200,
                    ),
                    child: PasswordField(
                      controller: _controladorSenha,
                      label: 'Senha',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 400,
                      minWidth: 200,
                    ),
                    child: PasswordField(
                      controller: _controladorCSenha,
                      label: 'Confirme sua senha',
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      _cadastroSucesso();
                    },
                    child: const Text('Cadastrar'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
