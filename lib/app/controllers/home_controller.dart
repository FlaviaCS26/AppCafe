import 'package:cafe_gourmet/app/data/models/categoria_model.dart';
import 'package:cafe_gourmet/app/data/models/forma_pagamento_model.dart';
import 'package:cafe_gourmet/app/data/models/produto_model.dart';
import 'package:cafe_gourmet/app/data/models/promocao_model.dart';
import 'package:cafe_gourmet/app/data/services/categorias_service.dart';
import 'package:cafe_gourmet/app/data/services/formas_pagamento_service.dart';
import 'package:cafe_gourmet/app/data/services/produtos_service.dart';
import 'package:cafe_gourmet/app/data/services/promocoes_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  ///instância para buscar as informações no banco de dados
  final produtosService = ProdutosService();
  final categoriasService = CategoriasService();
  final promocoesService = PromocoesService();
  final formasPagamentoService = FormasPagamentoService();

  HomeController() {
    init();
  }

  ///Busca todas informações necessárias
  init() async {
    _atualizando.value = true;
    final response = await Future.wait([
      categoriasService.getCategorias(),
      produtosService.getProdutos(),
      promocoesService.getPromocoes(),
      formasPagamentoService.getFormasPagamento(),
    ]);
    _categorias.addAll(response[0] as List<CategoriaModel>);
    _categoria.value = categorias.first.descricao;
    _produtos.addAll(response[1] as List<ProdutoModel>);
    _promocoes.addAll(response[2] as List<PromocaoModel>);
    _formasPagamento.addAll(response[3] as List<FormaPagamentoModel>);
    _atualizando.value = false;
  }

  final _categoria = ''.obs;
  setCategoria(CategoriaModel value) => _categoria.value = value.descricao;
  CategoriaModel? get categoriaSelect {
    if (_categoria.isEmpty) return null;
    return categorias.firstWhere((e) => e.descricao == _categoria.value);
  }

  final _atualizando = false.obs;
  bool get atualizando => _atualizando.value;

  final _formasPagamento = <FormaPagamentoModel>[].obs;
  List<FormaPagamentoModel> get formasPagamento => _formasPagamento.toList();

  final _promocoes = <PromocaoModel>[].obs;
  List<PromocaoModel> get promocoes => _promocoes.toList();

  final _categorias = <CategoriaModel>[].obs;
  List<CategoriaModel> get categorias => _categorias.toList();

  final _produtos = <ProdutoModel>[].obs;
  List<ProdutoModel> get produtos => _produtos.toList();
  List<ProdutoModel> get produtosFilter {
    return produtos
        .where((e) => e.categoria == categoriaSelect?.descricao)
        .toList();
  }

  List<ProdutoModel> get produtosRecomendacaoFilter {
    final produtosFiltrado = produtosFilter;
    produtosFiltrado.sort((a, b) => b.recomendacao.compareTo(a.recomendacao));
    if (produtosFiltrado.length > 7) {
      return produtosFiltrado.getRange(0, 7).toList();
    }
    return produtosFiltrado;
  }
}
