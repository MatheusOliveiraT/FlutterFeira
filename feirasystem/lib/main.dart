import 'package:feirasystem/agendamentoAtividadeFeira/agendamentoAtividadeFeiraWidget.dart';
import 'package:feirasystem/departamento/departamentoWidget.dart';
import 'package:feirasystem/homepage/homePageMonitor.dart';
import 'package:feirasystem/homepage/homePageOrganizador.dart';
import 'package:feirasystem/pessoa/loginWidget.dart';
import 'package:feirasystem/pessoa/monitor/perfilMonitorWidget.dart';
import 'package:feirasystem/pessoa/organizador/perfilOrganizadorWidget.dart';
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
        bottomAppBarTheme: const BottomAppBarTheme(
          elevation: 4.0,
          shadowColor: Color.fromARGB(255, 0, 0, 0),
          color: Color.fromARGB(255, 254, 204, 23),
        ),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 25, 42, 50),
        ),
        cardTheme: const CardTheme(
          color: Color.fromARGB(255, 255, 245, 218),
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
          errorStyle: const TextStyle(
            height: 0,
            fontSize: 0,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
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
      onGenerateRoute: gerarRotaComAnimacao,
      initialRoute: '',
    );
  }
}

Route<dynamic> gerarRotaComAnimacao(RouteSettings settings) {
  late final Widget pagina;

  switch (settings.name) {
    case '':
      pagina = const Pessoas();
      break;
    case 'homePage':
      pagina = const HomePage();
      break;
    case 'organizador':
      pagina = const HomePageOrganizador();
      break;
    case 'monitor':
      pagina = const HomePageMonitor();
      break;
    case 'cadastro':
      pagina = const Cadastro();
      break;
    case 'cadastro/localidade':
      pagina = const Localidades();
      break;
    case 'cadastro/sublocalidade':
      pagina = const Sublocalidades();
      break;
    case 'cadastro/atividade':
      pagina = const Atividades();
      break;
    case 'cadastro/feira':
      pagina = const Feiras();
      break;
    case 'cadastro/agendamentofeira':
      pagina = const AgendamentosFeira();
      break;
    case 'cadastro/departamento':
      pagina = const Departamentos();
      break;
    case 'cadastro/professor':
      pagina = const Professores();
      break;
    case 'cadastro/agendamentoAtividadeFeira':
      pagina = const AgendamentosAtividadeFeira();
      break;
    case 'usuario/login':
      pagina = const Login();
      break;
    case 'usuario/organizador':
      pagina = const Organizadores();
      break;
    case 'usuario/monitor':
      pagina = const Monitores();
      break;
    case 'usuario/perfil/organizador':
      pagina = const PerfilOrganizadores();
      break;
    case 'usuario/perfil/monitor':
      pagina = const PerfilMonitores();
      break;
  }

  return PageRouteBuilder(
    settings: settings,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) => pagina,
    transitionsBuilder: (_, animation, __, child) {
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      );
      final scaleAnimation =
          Tween<double>(begin: 0.9, end: 1.0).animate(curvedAnimation);
      final fadeAnimation =
          Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation);
      return FadeTransition(
        opacity: fadeAnimation,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: child,
        ),
      );
    },
  );
}
