import 'package:cafe_gourmet/app/data/models/produto_model.dart';
import 'package:cafe_gourmet/app/ui/global_widgets/image_network.dart';
import 'package:cafe_gourmet/app/ui/global_widgets/start_rating.dart';
import 'package:cafe_gourmet/app/ui/pages/product/product_screen.dart';
import 'package:cafe_gourmet/app/ui/theme/theme.dart';
import 'package:cafe_gourmet/app/ui/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class RecommendationHomeScreen extends StatelessWidget {
  final double? height;
  final bool atualizando;
  final List<ProdutoModel> produtos;
  final String categoria;

  const RecommendationHomeScreen({
    super.key,
    this.height,
    this.atualizando = false,
    required this.produtos,
    required this.categoria,
  });

  double get heightCard => height ?? Get.size.height * .22;
  double get weightCard => Get.size.width * .35;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              'Recomendações',
              style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: heightCard,
            width: Get.size.width,
            child: listCards(),
          ),
        ],
      ),
    );
  }

  Widget listCards() {
    if (atualizando) {
      return const Center(
        child: SizedBox(
          height: 50.0,
          width: 50.0,
          child: CircularProgressIndicator(
            color: ThemeBase.color,
          ),
        ),
      );
    }

    if (produtos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: FaIcon(
                FontAwesomeIcons.circleExclamation,
                color: Colors.grey.withOpacity(.8),
                size: 35.0,
              ),
            ),
            Text(
              'Nenhum ${categoria.toLowerCase()} encontrado...',
              style: TextStyle(
                color: Colors.grey.withOpacity(.8),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: produtos.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (c, i) => cardProduto(i),
    );
  }

  Widget cardProduto(int index) {
    final i = produtos[index];
    final last = index + 1 == produtos.length;
    final sizeImage = heightCard * .45;

    return Padding(
      padding: EdgeInsets.only(right: last ? 0 : 15.0),
      child: GestureDetector(
        onTap: () => Get.to(
          () => ProductScreen(model: i),
          transition: Transition.cupertino,
        ),
        child: Container(
          height: heightCard,
          width: weightCard,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.grey[100],
                height: heightCard * .55,
                width: weightCard,
                child: Center(
                  child: WImageNetwork(
                    margin: const EdgeInsets.all(10.0),
                    url: i.urlImage,
                    height: sizeImage,
                    width: sizeImage,
                  ),
                ),
              ),
              Text(
                i.descricao,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Format.formatReais(i.valores.first.valor),
                    style: const TextStyle(
                      color: ThemeBase.color,
                      fontSize: 13.0,
                    ),
                  ),
                  WDStarRating(
                    value: i.recomendacao,
                    enabled: false,
                    sizeStar: 10.0,
                    spacingStars: 0,
                    colorStars: Colors.amber,
                    onChanged: (v) {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
