import 'package:cafe_gourmet/app/controllers/home_controller.dart';
import 'package:cafe_gourmet/app/data/models/carrinho_model.dart';
import 'package:cafe_gourmet/app/data/models/pedido_model.dart';
import 'package:cafe_gourmet/app/ui/global_widgets/image_network.dart';
import 'package:cafe_gourmet/app/ui/theme/theme.dart';
import 'package:cafe_gourmet/app/ui/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CardItemRequestsScreen extends StatelessWidget {
  final HomeController controller = Get.find();
  final PedidoModel model;
  CardItemRequestsScreen({
    super.key,
    required this.model,
  });

  final heightCard = Get.size.height * .15;
  final weightCard = Get.size.width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: SizedBox(
        width: weightCard,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              topCard(),
              ...model.produtos.map(cardItem),
            ],
          ),
        ),
      ),
    );
  }

  Widget topCard() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 7.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Format.formatReais(model.valorTotal),
            style: const TextStyle(
              color: ThemeBase.color,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          formaPagamento(),
          Text(
            DateFormat('dd/MM/yyyy HH:mm').format(
              model.dataCompra.toLocal(),
            ),
            style: const TextStyle(
              color: Colors.black38,
              fontSize: 13.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget formaPagamento() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            right: 5.0,
          ),
          child: FaIcon(
            model.formaPagamento.iconeData,
            size: 13.0,
            color: ThemeBase.color.withOpacity(.7),
          ),
        ),
        Text(
          model.formaPagamento.descricao,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: ThemeBase.color.withOpacity(.7),
            fontSize: 13.0,
          ),
        ),
      ],
    );
  }

  Widget cardItem(CarrinhoModel c) {
    final m = controller.produtos.firstWhere(
      (e) => e.codigo == c.codigoProduto,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.grey[100],
                padding: const EdgeInsets.all(12.0),
                child: WImageNetwork(
                  url: m.urlImage,
                  width: Get.size.width * .1,
                  height: Get.size.width * .1,
                  borderRadius: 10.0,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 3.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 7.0,
                      ),
                      child: Text(
                        m.descricao,
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Med.: ${c.modelo}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 13.0,
                          ),
                        ),
                        Text(
                          'Quant: ${c.qtde}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 13.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: Get.size.width * .2,
            child: Text(
              Format.formatReais(c.valorTotal),
              style: const TextStyle(
                color: ThemeBase.color,
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
