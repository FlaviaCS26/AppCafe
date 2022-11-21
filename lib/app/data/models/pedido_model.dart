import 'package:cafe_gourmet/app/data/models/carrinho_model.dart';
import 'package:cafe_gourmet/app/data/models/forma_pagamento_model.dart';

class PedidoModel {
  late String id;
  late DateTime dataCompra;
  late List<CarrinhoModel> produtos;
  late FormaPagamentoModel formaPagamento;
  late double valorTotal;

  PedidoModel.fromNew(List<CarrinhoModel> itens, FormaPagamentoModel f) {
    dataCompra = DateTime.now().toLocal();
    id = '${dataCompra.millisecondsSinceEpoch}_${itens.length}';
    produtos = itens;
    formaPagamento = f;
    valorTotal = itens.map((e) => e.valorTotal).fold(0, (p, e) => p + e);
  }

  PedidoModel.fromJson(Map json) {
    id = json['id'];
    dataCompra = DateTime.parse(json['dataCompra']);
    produtos = (json['produtos'] as List)
        .map((e) => CarrinhoModel.fromJson(e))
        .toList();
    formaPagamento = FormaPagamentoModel.fromJson(
      json['formaPagamento'],
    );
    valorTotal = json['valorTotal'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['dataCompra'] = dataCompra.toIso8601String();
    data['produtos'] = produtos.map((e) => e.toJson()).toList();
    data['formaPagamento'] = formaPagamento.toJson();
    data['valorTotal'] = valorTotal;
    return data;
  }
}
