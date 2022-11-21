import 'package:cafe_gourmet/app/ui/global_widgets/button.dart';
import 'package:cafe_gourmet/app/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomScreenProduct extends StatelessWidget {
  final bool processando;
  final bool insert;
  final int qtde;
  final Function(int v) onChanged;
  final Function() onSelect;

  const BottomScreenProduct({
    super.key,
    this.processando = false,
    this.insert = true,
    required this.qtde,
    required this.onChanged,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: Get.size.width * .55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              button(false),
              Text(
                qtde.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
              button(true),
            ],
          ),
        ),
        WButton(
          colorBackground: Colors.white,
          colorText: ThemeBase.color,
          fontWeight: FontWeight.bold,
          colorLoading: ThemeBase.color,
          elevation: 7.0,
          text: insert ? 'Adicionar no Carrinho' : 'Alterar item',
          margin: const EdgeInsets.only(top: 40.0),
          size: Size(Get.size.width * .6, Get.size.height * .07),
          loading: processando,
          onSelect: onSelect,
        ),
      ],
    );
  }

  Widget button(bool plus) {
    return InkWell(
      borderRadius: BorderRadius.circular(90.0),
      highlightColor: Colors.white24,
      hoverColor: Colors.white30,
      onTap: () {
        int v = qtde;
        if (plus) v += 1;
        if (!plus && v > 0) v -= 1;
        onChanged(v);
      },
      child: Container(
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white54,
          ),
          borderRadius: BorderRadius.circular(90.0),
        ),
        child: Center(
          child: Icon(
            plus ? Icons.add : Icons.remove,
            color: Colors.white,
            size: 19.0,
          ),
        ),
      ),
    );
  }
}
