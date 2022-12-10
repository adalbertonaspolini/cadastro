import 'package:cadastro/paginas/busca_cidade.dart';
import 'package:cadastro/paginas/busca_pessoa.dart';
import 'package:cadastro/paginas/cadastro.dart';
import 'package:cadastro/paginas/cadastro_cidade.dart';
import 'package:cadastro/paginas/consulta.dart';
import 'package:cadastro/paginas/consulta_cidade.dart';
import 'package:cadastro/paginas/home.dart';
import 'package:cadastro/util/tema.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Tema().criaTema(),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const Home(),
        '/consulta': (context) => const Consulta(),
        '/cadastro': (context) => const Cadastro(),
        '/cadastroCidade': (context) => const CadastroCidade(),
        '/consultaCidade': (context) => const ConsultaCidade(),
        '/buscaPessoa': (context) => const BuscaPessoa(),
        '/buscaCidade': (context) => const BuscaCidade(),
      },
    );
  }
}
