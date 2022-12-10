import 'dart:convert';

import 'cidade.dart';

class Pessoa {
  int id;
  String nome;
  String sexo;
  int idade;
  Cidade cidade;

  Pessoa(this.id, this.nome, this.sexo, this.idade, this.cidade);

  factory Pessoa.fromJson(dynamic json) {
    return Pessoa(
        json["id"] as int,
        json["nome"] as String,
        json["sexo"] as String,
        json["idade"] as int,
        Cidade.fromJson(json["cidade"]));
  }

  Map<String, dynamic> toJson() => {
        if (id != 0) 'id': id,
        'nome': nome,
        'sexo': sexo,
        'idade': idade,
        'cidade': cidade.toJson()
      };
}
