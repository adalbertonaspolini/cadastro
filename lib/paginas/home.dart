import 'package:cadastro/model/cidade.dart';
import 'package:cadastro/model/pessoa.dart';
import 'package:cadastro/util/componentes.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    cadastro() {
      Navigator.of(context).pushReplacementNamed('/cadastro',
          arguments: Pessoa(0, "", "", 0, Cidade(0, "", "")));
    }

    consulta() {
      Navigator.of(context).pushReplacementNamed('/consulta');
    }

    cadastroCidade() {
      Navigator.of(context).pushReplacementNamed('/cadastroCidade',
          arguments: Cidade(0, "", ""));
    }

    consultaCidade() {
      Navigator.of(context).pushReplacementNamed('/consultaCidade');
    }

    buscaPessoa() {
      Navigator.of(context).pushReplacementNamed('/buscaPessoa');
    }

    buscaCidade() {
      Navigator.of(context).pushReplacementNamed('/buscaCidade');
    }

    return Scaffold(
      appBar: Componentes().criaAppBar("Utilização API", home),
      body: Form(
        key: formController,
        child: Column(
          children: [
            Componentes()
                .criaBotao(formController, cadastro, "Cadastro Pessoa"),
            Componentes()
                .criaBotao(formController, consulta, "Consulta Pessoa"),
            Componentes()
                .criaBotao(formController, cadastroCidade, "Cadastro Cidade"),
            Componentes()
                .criaBotao(formController, consultaCidade, "Consulta Cidade"),
            Componentes().criaBotao(
                formController, buscaPessoa, "Busca Pessoa por Cidade"),
            Componentes()
                .criaBotao(formController, buscaCidade, "Busca Cidade por UF"),
          ],
        ),
      ),
    );
  }
}
