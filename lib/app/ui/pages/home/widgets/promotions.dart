import 'package:cafe_gourmet/app/data/models/promocao_model.dart';
import 'package:cafe_gourmet/app/ui/global_widgets/carousel.dart';
import 'package:cafe_gourmet/app/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class PromotionsHomeScreen extends StatelessWidget {
  final bool atualizando;
  final double? heightImages;
  final List<PromocaoModel> images;

  const PromotionsHomeScreen({
    super.key,
    required this.images,
    this.atualizando = false,
    this.heightImages,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            'Promoções para você',
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(child: listCarousel()),
      ],
    );
  }

  Widget listCarousel() {
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

    return WCarouselImage(
      images: images.map((e) => e.urlImage).toList(),
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      borderRadius: 15.0,
    );
  }
}
