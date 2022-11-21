import 'package:cafe_gourmet/app/data/models/carrinho_model.dart';
import 'package:cafe_gourmet/app/data/models/usuario_model.dart';
import 'package:cafe_gourmet/app/data/services/carrinho_service.dart';
import 'package:get/get.dart';

class CarrinhoController extends GetxController {
  final UsuarioModel model;
  late CarrinhoService carrinhoService;

  CarrinhoController(this.model) {
    carrinhoService = CarrinhoService(model);
    atualizarListagem();
  }

  Future<void> atualizarListagem() async {
    _atualizando.value = true;
    final response = await carrinhoService.getCarrinho();
    response.sort(
      (a, b) => '${a.codigoProduto}_${a.modelo}'
          .compareTo('${b.codigoProduto}_${b.modelo}'),
    );
    _listagem.clear();
    _listagem.addAll(response);
    _atualizando.value = false;
  }

  final _atualizando = false.obs;
  bool get atualizando => _atualizando.value;

  final _listagem = <CarrinhoModel>[].obs;
  List<CarrinhoModel> get listagem => _listagem.toList();

  Future<bool> insertItem(CarrinhoModel c) async {
    CarrinhoModel? contain;
    for (CarrinhoModel m in listagem) {
      if (m.id == c.id) {
        contain = m;
        break;
      }
    }

    if (contain != null) {
      //edita o mesmo item e modelo no carrinho
      c.setId(contain.id);
      c.setQtde(contain.qtde + c.qtde);
      return await updateItem(c);
    } else {
      //insere o item e modelo no carrinho
      final response = await carrinhoService.insertCarrinho(c);
      await atualizarListagem();
      return response != null;
    }
  }

  int get newId {
    if (listagem.isEmpty) return 1;
    return listagem.length + 1;
  }

  Future<bool> updateItem(CarrinhoModel c) async {
    final response = await carrinhoService.updateCarrinho(c);
    await atualizarListagem();
    return response != null;
  }

  Future<bool> deleteItem(CarrinhoModel c) async {
    final response = await carrinhoService.deleteCarrinho(c.id);
    await atualizarListagem();
    return response;
  }

  Future<void> deleteAllItem() async {
    await carrinhoService.deleteAllCarrinho();
    await atualizarListagem();
  }
}
