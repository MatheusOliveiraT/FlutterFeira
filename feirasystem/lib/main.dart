import 'package:feirasystem/departamento/departamentoWidget.dart';
import 'pessoa/monitor/perfilMonitorWidget.dart';
// import 'package:feirasystem/pessoa/organizador/perfilOrganizadorWidget.dart';
import 'package:feirasystem/pessoa/monitor/monitorWidget.dart';
import 'package:feirasystem/pessoa/organizador/organizadorWidget.dart';
import 'package:feirasystem/pessoa/pessoaWidget.dart';
import 'package:feirasystem/agendamentoFeira/agendamentoFeiraWidget.dart';
import 'package:feirasystem/atividade/atividadeWidget.dart';
import 'package:feirasystem/cadastro/cadastroWidget.dart';
import 'package:feirasystem/feira/feiraWidget.dart';
import 'package:feirasystem/localidade/localidadeWidget.dart';
import 'package:feirasystem/professor/professorWidget.dart';
import 'package:feirasystem/sublocalidade/sublocalidadeWidget.dart';
import 'package:feirasystem/homepage/homePageWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
            primary: const Color.fromARGB(255, 50, 136, 242),
            surface: const Color.fromARGB(255, 236, 239, 243)),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          elevation: 4.0,
          shadowColor: Color.fromARGB(255, 0, 0, 0),
          backgroundColor: Color.fromARGB(255, 254, 204, 23),
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 50, 136, 242),
                foregroundColor: Colors.white,
                elevation: 5,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                textStyle: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.normal))),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          floatingLabelStyle: const TextStyle(
              color: Color.fromARGB(255, 50, 136, 242),
              fontSize: 18,
              fontWeight: FontWeight.bold),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 50, 136, 242), width: 2.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        dropdownMenuTheme: const DropdownMenuThemeData(
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          menuStyle: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(
              Color.fromARGB(255, 236, 239, 243),
            ),
          ),
        ),
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: Color.fromARGB(255, 236, 239, 243),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        dialogTheme: const DialogTheme(
            backgroundColor: Color.fromARGB(255, 236, 239, 243)),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      initialRoute: '',
      routes: {
        '': (context) => const HomePage(),
        'cadastro': (context) => const Cadastro(),
        'cadastro/localidade': (context) => const Localidades(),
        'cadastro/sublocalidade': (context) => const Sublocalidades(),
        'cadastro/atividade': (context) => const Atividades(),
        'cadastro/feira': (context) => const Feiras(),
        'cadastro/agendamentofeira': (context) => const AgendamentosFeira(),
        'cadastro/departamento': (context) => const Departamentos(),
        'cadastro/professor': (context) => const Professores(),
        'usuario': (context) => const Pessoas(),
        'usuario/organizador': (context) => const Organizadores(),
        'usuario/monitor': (context) => const Monitores(),
        // 'perfil': (context) => const PerfilOrganizadores(),
        'perfil': (context) => const PerfilMonitores(),
      },
    );
  }
}
