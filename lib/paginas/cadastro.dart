import 'package:cadastro/api/acesso_api.dart';
import 'package:cadastro/model/cidade.dart';
import 'package:cadastro/util/combo_cidade.dart';
import 'package:cadastro/util/componentes.dart';
import 'package:cadastro/util/radio_sexo.dart';
import 'package:flutter/material.dart';

import '../model/pessoa.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtSexo = TextEditingController(text: 'M');
  TextEditingController txtIdade = TextEditingController();
  TextEditingController txtCidade = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Pessoa;
    txtNome.text = args.nome;
    txtSexo.text = args.sexo;
    txtIdade.text = args.idade == 0 ? '' : args.idade.toString();
    txtCidade.text = args.cidade.id.toString();

    cadastrar() async {
      Pessoa p = Pessoa(args.id, txtNome.text, txtSexo.text,
          int.parse(txtIdade.text), Cidade(int.parse(txtCidade.text), "", ""));
      if (p.id == 0) {
        await AcessoApi().inserePessoa(p.toJson());
      } else {
        await AcessoApi().alteraPessoa(p.toJson());
      }
      Navigator.of(context).pushNamed('/consulta');
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
                TextInputType.number, "Idade", txtIdade, "Informe a Idade"),
            Center(child: RadioSexo(controller: txtSexo)),
            Center(child: ComboCidade(controller: txtCidade)),
            Componentes().criaBotao(formController, cadastrar, "Cadastrar"),
          ],
        ),
      ),
    );
  }
}
