import 'package:cafe_gourmet/app/controllers/carrinho_controller.dart';
import 'package:cafe_gourmet/app/data/models/forma_pagamento_model.dart';
import 'package:cafe_gourmet/app/data/models/pedido_model.dart';
import 'package:cafe_gourmet/app/data/models/usuario_model.dart';
import 'package:cafe_gourmet/app/data/services/pedido_service.dart';
import 'package:get/get.dart';

class PedidosController extends GetxController {
  final CarrinhoController controller = Get.find();
  final UsuarioModel model;
  late PedidoService pedidoService;

  PedidosController(this.model) {
    pedidoService = PedidoService(model);
    atualizarListagem();
  }

  Future<void> atualizarListagem() async {
    _atualizando.value = true;
    final response = await pedidoService.getPedidos();
    response.sort((a, b) => b.dataCompra.compareTo(a.dataCompra));
    _listagem.clear();
    _listagem.addAll(response);
    _atualizando.value = false;
  }

  final _atualizando = false.obs;
  bool get atualizando => _atualizando.value;

  final _listagem = <PedidoModel>[].obs;
  List<PedidoModel> get listagem => _listagem.toList();

  Future<bool> insertPedido(FormaPagamentoModel f) async {
    final pModel = PedidoModel.fromNew(controller.listagem, f);
    final response = await pedidoService.insertPedido(pModel);
    if (response != null) {
      await controller.deleteAllItem();
    }
    await atualizarListagem();
    return response != null;
  }
}
