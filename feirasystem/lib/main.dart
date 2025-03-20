import 'package:feirasystem/agendamentoFeira/agendamentoFeiraWidget.dart';
import 'package:feirasystem/atividade/atividadeWidget.dart';
import 'package:feirasystem/cadastro/cadastroWidget.dart';
import 'package:feirasystem/feira/feiraWidget.dart';
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
              seedColor: const Color.fromARGB(255, 254, 204, 23),
              surface: const Color.fromARGB(255, 236, 239, 243)),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            elevation: 4.0,
            shadowColor: Color.fromARGB(255, 0, 0, 0),
            backgroundColor: Color.fromARGB(255, 254, 204, 23),
            centerTitle: true,
            titleTextStyle:
                TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 25, 42, 50),
              foregroundColor: Colors.white,
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color.fromARGB(255, 254, 204, 23),
          )),
      initialRoute: '',
      routes: {
        '': (context) => const HomePage(),
        'cadastro': (context) => const Cadastro(),
        'cadastro/localidade': (context) => const Localidades(),
        'cadastro/sublocalidade': (context) => const Sublocalidades(),
        'cadastro/atividade': (context) => const Atividades(),
        'cadastro/feira': (context) => const Feiras(),
        'cadastro/agendamentofeira': (context) => const AgendamentosFeira(),
      },
    );
  }
}
