import 'package:cafe_gourmet/app/data/models/produto_model.dart';
import 'package:cafe_gourmet/app/ui/global_widgets/image_network.dart';
import 'package:cafe_gourmet/app/ui/theme/theme.dart';
import 'package:cafe_gourmet/app/ui/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CenterScreenProduct extends StatelessWidget {
  final ProdutoModel model;
  final double value;
  final ValoresProdutoModel select;
  final Function(ValoresProdutoModel v) onSelect;
  const CenterScreenProduct({
    super.key,
    required this.model,
    required this.value,
    required this.select,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 40.0,
      ),
      child: Column(
        children: [
          Text(
            '${model.categoria} ${model.descricao}',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 25.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
            ),
            child: Text(
              Format.formatReais(value),
              style: TextStyle(
                color: Colors.yellow[400],
                fontSize: 20.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 40.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: model.valores.map(tamanhoItem).toList(),
                ),
                WImageNetwork(
                  margin: const EdgeInsets.only(left: 40.0),
                  url: model.urlImage,
                  height: Get.size.width * .5,
                  width: Get.size.width * .5,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget tamanhoItem(ValoresProdutoModel e) {
    final selectItem = select.descricao == e.descricao;

    return Container(
      constraints: const BoxConstraints(
        minHeight: 40.0,
        minWidth: 40.0,
        maxHeight: 40.0,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 13.0,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 5.0,
      ),
      decoration: BoxDecoration(
        color: selectItem ? Colors.yellow[300] : Colors.black.withOpacity(.09),
        border: Border.all(
          color: Colors.white30,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        hoverColor: Colors.yellow.withOpacity(.3),
        highlightColor: Colors.yellow.withOpacity(.2),
        borderRadius: BorderRadius.circular(8.0),
        onTap: () {
          if (!selectItem) onSelect(e);
        },
        child: Center(
          child: Text(
            e.descricao,
            style: TextStyle(
              color: selectItem ? ThemeBase.color : Colors.white,
              fontSize: 16.0,
              fontWeight: selectItem ? FontWeight.bold : null,
            ),
          ),
        ),
      ),
    );
  }
}
