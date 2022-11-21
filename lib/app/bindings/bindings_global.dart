import 'package:cafe_gourmet/app/controllers/carrinho_controller.dart';
import 'package:cafe_gourmet/app/controllers/home_controller.dart';
import 'package:cafe_gourmet/app/controllers/pedidos_controller.dart';
import 'package:cafe_gourmet/app/controllers/user_controller.dart';
import 'package:cafe_gourmet/app/data/models/usuario_model.dart';
import 'package:get/get.dart';

class GlobalBinding implements Bindings {
  final UsuarioModel model;
  GlobalBinding(this.model);

  @override
  void dependencies() {
    Get.put(CarrinhoController(model));
    Get.put(PedidosController(model));
    Get.put(UserController(model));
    Get.put(HomeController());
  }
}
