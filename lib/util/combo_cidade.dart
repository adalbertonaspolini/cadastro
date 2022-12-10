import 'package:cadastro/api/acesso_api.dart';
import 'package:cadastro/model/cidade.dart';
import 'package:flutter/material.dart';

class ComboCidade extends StatefulWidget {
  TextEditingController? controller;

  ComboCidade({Key? key, this.controller}) : super(key: key);

  @override
  State<ComboCidade> createState() => _ComboCidadeState();
}

class _ComboCidadeState extends State<ComboCidade> {
  int? cidadesel;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 1))
          .then((value) => AcessoApi().listaCidades()),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          List<Cidade> cidades = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton(
              isExpanded: true,
              value: cidadesel,
              icon: const Icon(Icons.arrow_downward),
              hint: const Text('Selecione uma Cidade.....'),
              elevation: 16,
              onChanged: (int? value) {
                setState(() {
                  cidadesel = value;
                  widget.controller?.text = "$value";
                });
              },
              items: cidades.map<DropdownMenuItem<int>>((Cidade cid) {
                return DropdownMenuItem<int>(
                    value: cid.id, child: Text(cid.nome));
              }).toList(),
            ),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              Text('Carregando Cidades'),
            ],
          );
        }
      },
    );
  }
}
