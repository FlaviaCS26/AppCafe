import 'package:cafe_gourmet/app/controllers/home_controller.dart';
import 'package:cafe_gourmet/app/controllers/pedidos_controller.dart';
import 'package:cafe_gourmet/app/ui/global_widgets/scaffold.dart';
import 'package:cafe_gourmet/app/ui/pages/requests/widgets/card_item.dart';
import 'package:cafe_gourmet/app/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class RequestsScreen extends StatelessWidget {
  final HomeController homeController = Get.find();
  final PedidosController controller = Get.find();
  RequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WScaffold(
      colorBackground: Colors.grey[100]!,
      bottomsNavigationBar: true,
      child: Obx(() => Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              children: [
                topScreen(),
                Expanded(child: centerScreen()),
              ],
            ),
          )),
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
              FontAwesomeIcons.clipboardList,
              color: ThemeBase.color,
              size: 19.0,
            ),
          ),
          Text(
            'Meus Pedidos',
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
        return CardItemRequestsScreen(
          model: controller.listagem[i],
        );
      },
    );
  }
}
