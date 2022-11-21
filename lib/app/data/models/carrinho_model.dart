import 'package:cafe_gourmet/app/data/models/produto_model.dart';

class CarrinhoModel {
  late String id;
  late String codigoProduto;
  late String modelo;
  int qtde = 0;
  double valorUnitario = 0;
  double get valorTotal => valorUnitario * qtde;

  setId(String v) => id = v;
  setQtde(int v) => qtde = v;
  setValorUnitario(double v) => valorUnitario = v;

  CarrinhoModel.fromNew(ProdutoModel p, String m, int q) {
    codigoProduto = p.codigo;
    modelo = m;
    id = '${codigoProduto}_$modelo';
    qtde = q;
  }

  CarrinhoModel.fromJson(Map json) {
    id = json['id'];
    codigoProduto = json['codigoProduto'];
    qtde = json['qtde'];
    modelo = json['modelo'];
    valorUnitario = double.parse(json['valorUnitario'].toString());
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'codigoProduto': codigoProduto,
      'modelo': modelo,
      'qtde': qtde,
      'valorUnitario': valorUnitario,
    };
  }
}
