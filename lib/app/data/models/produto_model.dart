import 'package:flutter/cupertino.dart';

class ProdutoModel {
  late int id;
  late String codigo;
  late String descricao;
  late String categoria;
  late String urlImage;
  List<ValoresProdutoModel> valores = [];
  double recomendacao = 0;

  ImageProvider get providerImage => NetworkImage(urlImage);

  ProdutoModel.fromJson(Map json) {
    id = json.containsKey('id') ? json['id'] : 0;
    codigo = json['codigo'];
    descricao = json['descricao'];
    categoria = json['categoria'];
    urlImage = json['imagem'];
    recomendacao = json['recomendacao'];
    if (json.containsKey('valores')) {
      final r = List<Map>.from(json['valores'] as List<Object?>);
      valores.addAll(
        r.map((e) => ValoresProdutoModel.fromJson(e)).toList(),
      );
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['descricao'] = descricao;
    data['imagem'] = urlImage;
    return data;
  }
}

class ValoresProdutoModel {
  late String descricao;
  late double valor;

  ValoresProdutoModel.fromJson(Map json) {
    descricao = json['descricao'];
    valor = json['valor'];
  }
}
