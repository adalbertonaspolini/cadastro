import 'package:cadastro/util/componentes.dart';
import 'package:flutter/material.dart';

import '../api/acesso_api.dart';
import '../model/cidade.dart';

class ConsultaCidade extends StatefulWidget {
  const ConsultaCidade({Key? key}) : super(key: key);

  @override
  State<ConsultaCidade> createState() => _ConsultaCidadeState();
}

class _ConsultaCidadeState extends State<ConsultaCidade> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  List<Cidade> lista = [];

  listarTodas() async {
    List<Cidade> cidades = await AcessoApi().listaCidades();
    setState(() {
      lista = cidades;
    });
  }

  criaItemCidade(Cidade c, context) {
    return ListTile(
      title: Componentes().criatexto("${c.id} - ${c.nome}/${c.uf}"),
      trailing: FittedBox(
        fit: BoxFit.fill,
        child: Row(
          children: [
            IconButton(
                icon: const Icon(Icons.edit),
                color: Colors.amber,
                onPressed: (() {
                  Navigator.pushNamed(
                    context,
                    "/cadastroCidade",
                    arguments: c,
                  );
                })),
            IconButton(
              icon: const Icon(Icons.delete_forever_outlined),
              color: Colors.red,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Excluir Cidade'),
                    content: const Text('Tem certeza?'),
                    actions: <Widget>[
                      ElevatedButton(
                        child: const Text('Não'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        child: const Text('Sim'),
                        onPressed: () async {
                          await AcessoApi().excluiCidade(c.id);
                          setState(() {
                            listarTodas();
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    listarTodas();
  }

  @override
  Widget build(BuildContext context) {
    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    irTelaCadastro() {
      Navigator.pushNamed(
        context,
        "/cadastroCidade",
        arguments: Cidade(0, "", ""),
      );
    }

    return Scaffold(
      appBar: Componentes().criaAppBar("Utilização API", home),
      body: Form(
        key: formController,
        child: Column(
          children: [
            Componentes()
                .criaBotao(formController, listarTodas, "Listar Todas"),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: lista.length,
                  itemBuilder: (context, indice) {
                    return Card(
                      elevation: 6,
                      margin: const EdgeInsets.all(5),
                      child: criaItemCidade(lista[indice], context),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: irTelaCadastro,
        child: const Icon(Icons.add),
      ),
    );
  }
}
