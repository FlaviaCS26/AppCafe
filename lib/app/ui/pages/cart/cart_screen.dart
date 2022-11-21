import 'package:cafe_gourmet/app/controllers/carrinho_controller.dart';
import 'package:cafe_gourmet/app/controllers/home_controller.dart';
import 'package:cafe_gourmet/app/ui/global_widgets/button.dart';
import 'package:cafe_gourmet/app/ui/global_widgets/scaffold.dart';
import 'package:cafe_gourmet/app/ui/pages/cart/payment_methods_screen.dart';
import 'package:cafe_gourmet/app/ui/pages/cart/widgets/card_item.dart';
import 'package:cafe_gourmet/app/ui/theme/theme.dart';
import 'package:cafe_gourmet/app/ui/utils/alerts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  final CarrinhoController controller = Get.find();
  final HomeController homeController = Get.find();
  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WScaffold(
      colorBackground: Colors.grey[100]!,
      bottomsNavigationBar: true,
      child: Obx(() => body()),
    );
  }

  Widget body() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Column(
        children: [
          topScreen(),
          Expanded(child: centerScreen()),
          if (controller.listagem.isNotEmpty) bottomScreen(),
        ],
      ),
    );
  }

  Widget topScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: FaIcon(
              FontAwesomeIcons.cartShopping,
              color: ThemeBase.color,
              size: 19.0,
            ),
          ),
          Text(
            'Carrinho de Compras',
            style: TextStyle(
              color: ThemeBase.color,
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget centerScreen() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: controller.listagem.length,
      itemBuilder: (c, i) {
        final c = controller.listagem[i];
        final m = homeController.produtos.firstWhere(
          (e) => e.codigo == c.codigoProduto,
        );
        c.setValorUnitario(
          m.valores.firstWhere((e) => e.descricao == c.modelo).valor,
        );
        return CardItemCartScreen(
          c: c,
          m: m,
          onDelete: () async {
            if (await Alerts().questionSnackbar(
              'Deseja excluir o item selecionado?',
            )) {
              controller.deleteItem(c);
            }
          },
        );
      },
    );
  }

  Widget bottomScreen() {
    return WButton(
      text: 'Realizar compra',
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 15.0,
      ),
      onSelect: () => Get.to(
        () => const PaymentMethodsScreen(),
        transition: Transition.cupertino,
      ),
    );
  }
}
