import 'package:cafe_gourmet/app/data/models/carrinho_model.dart';
import 'package:cafe_gourmet/app/data/models/produto_model.dart';
import 'package:cafe_gourmet/app/ui/global_widgets/image_network.dart';
import 'package:cafe_gourmet/app/ui/pages/product/product_screen.dart';
import 'package:cafe_gourmet/app/ui/theme/theme.dart';
import 'package:cafe_gourmet/app/ui/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class CardItemCartScreen extends StatelessWidget {
  final CarrinhoModel c;
  final ProdutoModel m;
  final Function() onDelete;
  CardItemCartScreen({
    super.key,
    required this.c,
    required this.m,
    required this.onDelete,
  });

  final heightCard = Get.size.height * .11;
  final weightCard = Get.size.width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
      ),
      child: SizedBox(
        height: heightCard,
        width: weightCard,
        child: Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  Get.to(
                    () => ProductScreen(model: m, carrinho: c),
                    transition: Transition.cupertino,
                  );
                },
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.orange,
                icon: Icons.edit,
                label: 'Editar',
                borderRadius: BorderRadius.circular(10.0),
              ),
              SlidableAction(
                onPressed: (c) => onDelete(),
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.red,
                icon: Icons.restore_from_trash,
                label: 'Remover',
                borderRadius: BorderRadius.circular(10.0),
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.all(9.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: Colors.grey[100],
                  height: heightCard,
                  width: heightCard,
                  child: Center(
                    child: WImageNetwork(
                      url: m.urlImage,
                      margin: const EdgeInsets.all(17.0),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5.0,
                          ),
                          child: Text(
                            m.descricao,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                        ),
                      ],
                    ),
                  ),
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
          ),
        ),
      ),
    );
  }
}
