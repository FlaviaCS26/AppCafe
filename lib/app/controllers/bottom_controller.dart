import 'package:cafe_gourmet/app/controllers/carrinho_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class BottomController extends GetxController {
  BottomController() {
    _lista.addAll([
      BottomItemController(
        icon: FontAwesomeIcons.house,
        caminho: '/home',
      ),
      BottomItemController(
        icon: FontAwesomeIcons.clipboardList,
        caminho: '/pedidos',
      ),
      BottomItemController(
        icon: FontAwesomeIcons.cartShopping,
        caminho: '/carrinho',
      ),
      BottomItemController(
        icon: FontAwesomeIcons.solidUser,
        caminho: '/perfil',
      ),
    ]);
  }

  final _lista = <BottomItemController>[].obs;
  List<BottomItemController> get lista => _lista.toList();
}

class BottomItemController extends GetxController {
  final CarrinhoController carrinhoController = Get.find();
  late String url;
  late IconData icone;

  int get notify {
    if (url.contains('/carrinho')) return carrinhoController.listagem.length;
    return 0;
  }

  BottomItemController({
    required String caminho,
    required IconData icon,
  }) {
    url = caminho;
    icone = icon;
  }
}
