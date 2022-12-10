import 'dart:convert';
import 'package:http/http.dart';

import 'package:cadastro/model/pessoa.dart';

import 'package:cadastro/model/cidade.dart';

class AcessoApi {
  Future<List<Pessoa>> listaPessoas() async {
    String url = 'http://localhost:8080/cliente';
    Response resposta = await get(Uri.parse(url));
    String jsonFormatadoUft8 = (utf8.decode(resposta.bodyBytes));
    Iterable l = json.decode(jsonFormatadoUft8);
    List<Pessoa> pessoas = List<Pessoa>.from(l.map((p) => Pessoa.fromJson(p)));
    return pessoas;
  }

  Future<List<Cidade>> listaCidades() async {
    String url = 'http://localhost:8080/cidade';
    Response resposta = await get(Uri.parse(url));
    String jsonFormatadoUft8 = (utf8.decode(resposta.bodyBytes));
    Iterable l = json.decode(jsonFormatadoUft8);
    List<Cidade> cidades = List<Cidade>.from(l.map((c) => Cidade.fromJson(c)));
    return cidades;
  }

  Future<void> inserePessoa(Map<String, dynamic> pessoa) async {
    String url = 'http://localhost:8080/cliente';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    await post(Uri.parse(url), headers: headers, body: json.encode(pessoa));
  }

  Future<void> insereCidade(Map<String, dynamic> cidade) async {
    String url = 'http://localhost:8080/cidade';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    await post(Uri.parse(url), headers: headers, body: json.encode(cidade));
  }

  Future<void> alteraPessoa(Map<String, dynamic> pessoa) async {
    String url = "http://localhost:8080/cliente?id=${pessoa['id']}";
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    await put(Uri.parse(url), headers: headers, body: jsonEncode(pessoa));
  }

  Future<void> excluiPessoa(int id) async {
    String url = "http://localhost:8080/cliente/$id";
    await delete(Uri.parse(url));
  }

  Future<void> alteraCidade(Map<String, dynamic> cidade) async {
    String url = "http://localhost:8080/cidade?id=${cidade['id']}";
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    await put(Uri.parse(url), headers: headers, body: jsonEncode(cidade));
  }

  Future<void> excluiCidade(int id) async {
    String url = "http://localhost:8080/cidade/$id";
    await delete(Uri.parse(url));
  }

  Future<List<Pessoa>> buscaPessoas(int cidade) async {
    String url = 'http://localhost:8080/cliente/buscacidade/$cidade';
    Response resposta = await get(Uri.parse(url));
    String jsonFormatadoUft8 = (utf8.decode(resposta.bodyBytes));
    Iterable l = json.decode(jsonFormatadoUft8);
    List<Pessoa> pessoas = List<Pessoa>.from(l.map((p) => Pessoa.fromJson(p)));
    return pessoas;
  }

  Future<List<Cidade>> buscaCidades(String uf) async {
    String url = 'http://localhost:8080/cidade/buscauf/$uf';
    print(url);

    Response resposta = await get(Uri.parse(url));
    String jsonFormatadoUft8 = (utf8.decode(resposta.bodyBytes));
    Iterable l = json.decode(jsonFormatadoUft8);
    List<Cidade> cidades = List<Cidade>.from(l.map((c) => Cidade.fromJson(c)));
    return cidades;
  }
}
