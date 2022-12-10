import 'package:cadastro/paginas/cadastro.dart';
import 'package:cadastro/util/componentes.dart';
import 'package:flutter/material.dart';

import '../api/acesso_api.dart';
import '../model/cidade.dart';
import '../model/pessoa.dart';

class Consulta extends StatefulWidget {
  const Consulta({Key? key}) : super(key: key);

  @override
  State<Consulta> createState() => _ConsultaState();
}

class _ConsultaState extends State<Consulta> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  List<Pessoa> lista = [];

  listarTodas() async {
    List<Pessoa> pessoas = await AcessoApi().listaPessoas();
    setState(() {
      lista = pessoas;
    });
  }

  criaItemPessoa(Pessoa p, context) {
    String sexo = p.sexo == 'M' ? "Masculino" : "Feminino";
    return ListTile(
      title: Componentes().criatexto("${p.id} - ${p.nome}"),
      subtitle: Componentes().criatexto("${p.idade} anos - (${sexo}) "),
      trailing: Componentes().criatexto("${p.cidade.nome}/${p.cidade.uf}"),
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
        "/cadastro",
        arguments: Pessoa(0, "", "", 0, Cidade(0, "", "")),
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
                      child: Column(
                        children: [
                          criaItemPessoa(lista[indice], context),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.edit),
                                color: Colors.amber,
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/cadastro',
                                    arguments: lista[indice],
                                  );
                                },
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: const Icon(Icons.delete_forever_outlined),
                                color: Colors.red,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Excluir Pessoa'),
                                      content: Text('Tem certeza?'),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          child: Text('Não'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        ElevatedButton(
                                          child: const Text('Sim'),
                                          onPressed: () async {
                                            await AcessoApi()
                                                .excluiPessoa(lista[indice].id);
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
                          )
                        ],
                      ),
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
