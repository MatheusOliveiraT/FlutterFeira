import 'package:feirasystem/assets/bottomAppBarMonitor.dart';
import 'package:feirasystem/assets/customSnackBar.dart';
import 'package:feirasystem/assets/formFields/passwordField.dart';
import 'package:feirasystem/assets/formFields/phoneField.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilMonitores extends StatefulWidget {
  const PerfilMonitores({super.key});
  @override
  _PerfilMonitoresState createState() => _PerfilMonitoresState();
}

class _PerfilMonitoresState extends State<PerfilMonitores> {
  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorRa = TextEditingController();
  final TextEditingController _controladorEmail = TextEditingController();
  final TextEditingController _controladorCelular = TextEditingController();
  final TextEditingController _controladorSenha = TextEditingController();
  final TextEditingController _controladorNSenha = TextEditingController();
  final TextEditingController _controladorCSenha = TextEditingController();
  bool _editSenha = false;

  @override
  void initState() {
    super.initState();
    _getSharedPreferences();
  }

  Future<void> _getSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _controladorNome.text = prefs.getString('nome') ?? '';
      _controladorRa.text = prefs.getString('ra') ?? '';
      _controladorEmail.text = prefs.getString('email') ?? '';
      _controladorCelular.text = prefs.getString('celular') ?? '';
    });
  }

  bool _validarForm() {
    String nome = _controladorNome.text.trim();
    String ra = _controladorRa.text.trim();
    String email = _controladorEmail.text.trim();
    String celular = _controladorCelular.text.trim();
    String senha = _controladorSenha.text.trim();
    String nsenha = _controladorNSenha.text.trim();
    String csenha = _controladorCSenha.text.trim();

    if (_editSenha) {
      if (nome.isEmpty ||
          ra.isEmpty ||
          celular.isEmpty ||
          email.isEmpty ||
          senha.isEmpty ||
          nsenha.isEmpty ||
          csenha.isEmpty) {
        showCustomSnackBar(context, 'Preencha todos os campos obrigatórios!',
            tipo: 'erro', duracao: 1);
        return false;
      }
    } else {
      if (nome.isEmpty || ra.isEmpty || celular.isEmpty || email.isEmpty) {
        showCustomSnackBar(context, 'Preencha todos os campos obrigatórios!',
            tipo: 'erro', duracao: 1);
        return false;
      }
    }
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(email)) {
      showCustomSnackBar(context, 'E-mail inválido.', tipo: 'erro', duracao: 1);
      return false;
    }
    if (celular.length < 14) {
      showCustomSnackBar(context, 'Número de celular inválido.',
          tipo: 'erro', duracao: 1);
      return false;
    }
    if (int.tryParse(ra) == null) {
      showCustomSnackBar(context, 'RA precisa ser um número inteiro.',
          tipo: 'erro', duracao: 2);
      return false;
    }
    if (_editSenha && nsenha != csenha) {
      showCustomSnackBar(context, 'Senhas digitadas não correspondem.',
          tipo: 'erro', duracao: 1);
      return false;
    }
    if (_editSenha && nsenha.length < 8) {
      showCustomSnackBar(context,
          'Senha muito curta. Sua senha deve ter pelo menos 8 dígitos.',
          tipo: 'erro', duracao: 2);
      return false;
    }
    return true;
  }

  void _editConta() async {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Editar seus dados'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _controladorNome,
                      decoration: const InputDecoration(labelText: 'Nome'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _controladorRa,
                      decoration: const InputDecoration(labelText: 'RA'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _controladorEmail,
                      decoration: const InputDecoration(labelText: 'E-mail'),
                    ),
                    const SizedBox(height: 10),
                    PhoneField(controller: _controladorCelular),
                    _construirFormularioDinamico(),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Voltar'),
                ),
                TextButton(
                  onPressed: () => setStateDialog(() {
                    _editSenha = !_editSenha;
                  }),
                  child: const Text('Editar senha'),
                ),
                TextButton(
                  onPressed: () async {
                    if (_validarForm()) {
                      try {
                        // TO DO - API CONNECTION
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('nome', _controladorNome.text);
                        await prefs.setString('ra', _controladorRa.text);
                        await prefs.setString('email', _controladorEmail.text);
                        await prefs.setString(
                            'celular', _controladorCelular.text);
                        await _getSharedPreferences();
                        Navigator.pop(context);
                        showCustomSnackBar(context,
                            'Seus dados foram atualizados com sucesso!');
                        _editSenha = false;
                        _controladorSenha.clear();
                        _controladorNSenha.clear();
                        _controladorCSenha.clear();
                      } catch (e) {
                        showCustomSnackBar(context, e.toString(), tipo: 'erro');
                      }
                    }
                  },
                  child: const Text('Atualizar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _construirFormularioDinamico() {
    if (_editSenha) {
      return Column(children: [
        const SizedBox(height: 10),
        PasswordField(controller: _controladorSenha, label: 'Senha atual'),
        const SizedBox(height: 10),
        PasswordField(controller: _controladorNSenha, label: 'Nova senha'),
        const SizedBox(height: 10),
        PasswordField(
            controller: _controladorCSenha, label: 'Confirme a nova senha'),
      ]);
    } else {
      return const Column();
    }
  }

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
      // TO DO - API CONNECTION
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await _getSharedPreferences();
      Navigator.pushNamedAndRemoveUntil(
          context, '', (Route<dynamic> route) => false);
      showCustomSnackBar(context, 'Sua conta foi excluída com sucesso.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: RefreshIndicator(
          onRefresh: _getSharedPreferences,
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
                      child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListTile(
                            title: Text(_controladorNome.text),
                            subtitle: const Text('Nome'),
                          )),
                    ),
                    const SizedBox(height: 16),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 400,
                        minWidth: 200,
                      ),
                      child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListTile(
                            title: Text(_controladorRa.text),
                            subtitle: const Text('RA'),
                          )),
                    ),
                    const SizedBox(height: 16),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 400,
                        minWidth: 200,
                      ),
                      child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListTile(
                            title: Text(_controladorEmail.text),
                            subtitle: const Text('E-mail'),
                          )),
                    ),
                    const SizedBox(height: 16),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 400,
                        minWidth: 200,
                      ),
                      child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListTile(
                            title: Text(_controladorCelular.text),
                            subtitle: const Text('Celular'),
                          )),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        _editConta();
                      },
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
      bottomNavigationBar: const BottomAppBarMonitor(),
    );
  }
}
