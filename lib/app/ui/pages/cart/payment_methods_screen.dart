import 'package:cafe_gourmet/app/controllers/carrinho_controller.dart';
import 'package:cafe_gourmet/app/controllers/home_controller.dart';
import 'package:cafe_gourmet/app/ui/global_widgets/scaffold_detail.dart';
import 'package:cafe_gourmet/app/ui/pages/cart/processing_payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class PaymentMethodsScreen extends StatefulWidget {
  final bool view;
  const PaymentMethodsScreen({super.key, this.view = false});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final HomeController homeController = Get.find();
  final CarrinhoController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return WScaffoldDetail(
      title: 'Formas de Pagamento',
      child: centerScreen(),
    );
  }

  Widget centerScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 30.0,
      ),
      child: ListView.builder(
        itemCount: homeController.formasPagamento.length,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (c, i) => cardItem(i),
      ),
    );
  }

  Widget cardItem(int i) {
    final f = homeController.formasPagamento[i];

    return Container(
      constraints: const BoxConstraints(minHeight: 40.0, maxHeight: 40.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.09),
        border: Border.all(color: Colors.white30),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        hoverColor: Colors.yellow.withOpacity(.3),
        highlightColor: Colors.yellow.withOpacity(.2),
        splashColor: Colors.yellow.withOpacity(.2),
        borderRadius: BorderRadius.circular(8.0),
        onTap: () {
          if (!widget.view) {
            Get.off(
              () => ProcessingPaymentScreen(model: f),
              transition: Transition.cupertino,
            );
          }
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: SizedBox(
                width: Get.size.width * .1,
                child: FaIcon(
                  f.iconeData,
                  color: Colors.white,
                  size: 18.0,
                ),
              ),
            ),
            Expanded(
              child: Text(
                f.descricao,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: FaIcon(
                FontAwesomeIcons.angleRight,
                color: Colors.white,
                size: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
