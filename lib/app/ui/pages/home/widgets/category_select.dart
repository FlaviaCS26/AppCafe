import 'package:cafe_gourmet/app/data/models/categoria_model.dart';
import 'package:cafe_gourmet/app/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategorySelectHomeScreen extends StatelessWidget {
  final CategoriaModel? isSelect;
  final List<CategoriaModel> listagem;
  final Function(CategoriaModel m) onSelect;
  final EdgeInsetsGeometry margin;
  final bool atualizando;

  const CategorySelectHomeScreen({
    super.key,
    this.isSelect,
    this.margin = const EdgeInsets.symmetric(vertical: 10.0),
    this.atualizando = false,
    required this.listagem,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: margin, child: listCards());
  }

  Widget listCards() {
    if (atualizando) {
      return const SizedBox(
        height: 50.0,
        width: 50.0,
        child: Center(
          child: SizedBox(
            height: 40.0,
            width: 40.0,
            child: CircularProgressIndicator(
              color: ThemeBase.color,
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: listagem.map(category).toList(),
    );
  }

  Widget category(CategoriaModel m) {
    final select = isSelect != null && isSelect!.descricao == m.descricao;
    final colorBackground =
        select ? ThemeBase.color : Colors.grey.withOpacity(.2);
    final colorText = select ? Colors.white : Colors.black;

    return InkWell(
      onTap: () {
        if (isSelect != null && m.descricao == isSelect!.descricao) return;
        onSelect(m);
      },
      splashColor: ThemeBase.color.withOpacity(.4),
      highlightColor: ThemeBase.color.withOpacity(.2),
      borderRadius: BorderRadius.circular(90.0),
      child: Container(
        decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(90.0),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 15.0,
              child: FaIcon(
                m.icone,
                color: ThemeBase.color,
                size: 14.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 13.0,
              ),
              child: Text(
                m.descricao,
                style: TextStyle(
                  color: colorText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
