import 'package:cadastro/api/acesso_api.dart';
import 'package:cadastro/model/cidade.dart';
import 'package:cadastro/util/componentes.dart';
import 'package:flutter/material.dart';

class CadastroCidade extends StatefulWidget {
  const CadastroCidade({Key? key}) : super(key: key);

  @override
  State<CadastroCidade> createState() => _CadastroCidadeState();
}

class _CadastroCidadeState extends State<CadastroCidade> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtUf = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Cidade;
    txtNome.text = args.nome;
    txtUf.text = args.uf;

    cadastrar() async {
      Cidade c = Cidade(args.id, txtNome.text, txtUf.text);
      if (c.id == 0) {
        await AcessoApi().insereCidade(c.toJson());
      } else {
        await AcessoApi().alteraCidade(c.toJson());
      }
      Navigator.of(context).pushNamed('/consultaCidade');
    }

    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    return Scaffold(
      appBar: Componentes().criaAppBar("Utilização API", home),
      body: Form(
        key: formController,
        child: Column(
          children: [
            Componentes().criaInputTexto(
                TextInputType.text, "Nome", txtNome, "Informe o Nome"),
            Componentes().criaInputTexto(
                TextInputType.text, "UF", txtUf, "Informe a UF"),
            Componentes().criaBotao(formController, cadastrar, "Cadastrar"),
          ],
        ),
      ),
    );
  }
}
