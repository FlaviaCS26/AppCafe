import 'package:cafe_gourmet/app/ui/pages/cart/payment_methods_screen.dart';
import 'package:cafe_gourmet/app/ui/pages/user/screen/enderecos/enderecos_user.dart';
import 'package:cafe_gourmet/app/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ButtonsUser extends StatelessWidget {
  const ButtonsUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9.0),
      child: ListView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          cardButton(
            icon: FontAwesomeIcons.locationDot,
            desc: 'Meus endereços',
            onSelect: () => Get.to(
              () => const EnderecosUsersScreen(),
              transition: Transition.cupertino,
            ),
          ),
          cardButton(
            icon: FontAwesomeIcons.clipboardList,
            desc: 'Meus pedidos',
            onSelect: () => Get.toNamed('/pedidos'),
          ),
          cardButton(
            icon: FontAwesomeIcons.fileInvoiceDollar,
            desc: 'Formas de Pagamento',
            onSelect: () {
              Get.to(
                () => const PaymentMethodsScreen(view: true),
                transition: Transition.cupertino,
              );
            },
          ),
          cardButton(
            icon: FontAwesomeIcons.personCircleQuestion,
            desc: 'Central de Ajuda',
            onSelect: () {},
            margin: const EdgeInsets.only(top: 10.0),
          ),
          cardButton(
            icon: FontAwesomeIcons.headset,
            desc: 'Chat Café Gourmet',
            onSelect: () {},
          ),
          cardButton(
            icon: FontAwesomeIcons.circleInfo,
            desc: 'Sobre nós',
            onSelect: () {},
          ),
        ],
      ),
    );
  }

  Widget cardButton({
    required IconData icon,
    required String desc,
    required Function() onSelect,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
  }) {
    return Card(
      margin: margin,
      child: InkWell(
        onTap: onSelect,
        hoverColor: ThemeBase.color.withOpacity(.15),
        splashColor: ThemeBase.color.withOpacity(.2),
        highlightColor: ThemeBase.color.withOpacity(.25),
        child: Container(
          height: Get.size.height * .061,
          width: Get.size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(
                color: Colors.grey[300]!,
                width: 0.8,
              ),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: Get.size.width * .1,
                child: FaIcon(
                  icon,
                  size: 17.0,
                  color: ThemeBase.color.withOpacity(.85),
                ),
              ),
              Text(
                desc,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
