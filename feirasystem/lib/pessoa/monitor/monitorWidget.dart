import 'package:feirasystem/assets/customSnackBar.dart';
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
      showCustomSnackBar(context, 'Preencha todos os campos obrigatórios!',
          tipo: 'erro', duracao: 1);
      return false;
    }
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(email)) {
      showCustomSnackBar(context, 'E-mail inválido.', tipo: 'erro', duracao: 1);
      return false;
    }
    if (senha != csenha) {
      showCustomSnackBar(context, 'Senhas digitadas não correspondem!',
          tipo: 'erro', duracao: 1);
      return false;
    }
    if (senha.length < 8) {
      showCustomSnackBar(context,
          'Senha muito curta! Sua senha deve ter pelo menos 8 dígitos.',
          tipo: 'erro', duracao: 2);
      return false;
    }
    return true;
  }

  bool _cadastrar() {
    if (_validarForm()) {
      showCustomSnackBar(context, 'Cadastrado com sucesso!',
          tipo: 'sucesso', duracao: 2);
      Navigator.pushNamed(context, '');
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '';
                        }
                        return null;
                      },
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
                      _formKey.currentState!.validate();
                      _cadastrar();
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
