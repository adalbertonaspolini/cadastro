import 'package:cadastro/util/combo_cidade.dart';
import 'package:flutter/material.dart';

import '../model/cidade.dart';
import '../api/acesso_api.dart';
import '../model/pessoa.dart';
import '../util/componentes.dart';

class BuscaPessoa extends StatefulWidget {
  const BuscaPessoa({Key? key}) : super(key: key);

  @override
  State<BuscaPessoa> createState() => _BuscaPessoaState();
}

class _BuscaPessoaState extends State<BuscaPessoa> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtCidade = TextEditingController();
  List<Pessoa> lista = [];

  buscarTodas() async {
    List<Pessoa> pessoas =
        await AcessoApi().buscaPessoas(int.parse(txtCidade.text));
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
    buscarTodas();
  }

  @override
  Widget build(BuildContext context) {
    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    return Scaffold(
      appBar: Componentes().criaAppBar("Utilização API", home),
      body: Form(
        key: formController,
        child: Column(
          children: [
            ComboCidade(
              controller: txtCidade,
            ),
            Componentes().criaBotao(formController, buscarTodas, "Buscar"),
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
                                              buscarTodas();
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
    );
  }
}
