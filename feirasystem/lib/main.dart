import 'package:feirasystem/atividade/atividadeWidget.dart';
import 'package:feirasystem/cadastro/cadastroWidget.dart';
import 'package:feirasystem/localidade/localidadeWidget.dart';
import 'package:feirasystem/sublocalidade/sublocalidadeWidget.dart';
import 'package:feirasystem/homepage/homePageWidget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExpoUT());
}

class ExpoUT extends StatelessWidget {
  const ExpoUT({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feira de Profissões',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 255, 255, 0)),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 253, 251, 142)),
      ),
      initialRoute: '',
      routes: {
        '': (context) => const HomePage(title: 'Feira de Profissões'),
        'cadastro': (context) => const Cadastro(),
        'cadastro/localidade': (context) => const Localidades(),
        'cadastro/sublocalidade': (context) => const Sublocalidades(),
        'cadastro/atividade': (context) => const Atividades(),
      },
    );
  }
}
