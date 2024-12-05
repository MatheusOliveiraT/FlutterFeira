import 'package:feirasystem/atividade/atividadeWidget.dart';
import 'package:feirasystem/cadastro/cadastroWidget.dart';
import 'package:feirasystem/localidade/localidadeWidget.dart';
import 'package:feirasystem/sublocalidade/sublocalidadeWidget.dart';
import 'package:feirasystem/homepage/homePageWidget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feira de Profissões',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 251, 255, 41)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Feira de Profissões'),
        '/cadastro': (context) => const Cadastro(),
        '/cadastro/localidade': (context) => const Localidades(),
        '/cadastro/sublocalidade': (context) => const Sublocalidades(),
        '/cadastro/atividade': (context) => const Atividades(),
      },
    );
  }
}
