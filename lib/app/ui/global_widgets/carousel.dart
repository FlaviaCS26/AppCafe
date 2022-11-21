import 'package:cafe_gourmet/app/ui/global_widgets/image_network.dart';
import 'package:cafe_gourmet/app/ui/theme/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WCarouselImage extends StatefulWidget {
  final double? height;
  final double? width;
  final List<String> images;
  final double? borderRadius;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final int durationPause;
  final int durationTransition;
  final bool showIndicators;

  const WCarouselImage({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    required this.images,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.durationPause = 10,
    this.durationTransition = 2,
    this.showIndicators = true,
  });

  @override
  State<WCarouselImage> createState() => _WCarouselImageState();
}

class _WCarouselImageState extends State<WCarouselImage> {
  int _current = 0;
  final _controller = CarouselController();

  double get height => widget.height ?? Get.size.height;
  double get heightImage => height * .75;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
              viewportFraction: 1,
              initialPage: 0,
              aspectRatio: 16 / 8,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(
                seconds: widget.durationPause,
              ),
              autoPlayAnimationDuration: Duration(
                seconds: widget.durationTransition,
              ),
              autoPlayCurve: Curves.linear,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() => _current = index);
              },
            ),
            items: widget.images.map(imageView).toList(),
          ),
          if (widget.showIndicators)
            Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
                left: 15.0,
                right: 15.0,
              ),
              child: indicators(),
            ),
        ],
      ),
    );
  }

  Widget imageView(String image) {
    return WImageNetwork(
      url: image,
      fit: BoxFit.cover,
      borderRadius: widget.borderRadius ?? 0,
      margin: widget.padding,
    );
  }

  Widget indicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.images.asMap().entries.map((entry) {
        final atual = _current == entry.key;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: AnimatedContainer(
              height: 12.0,
              width: atual ? 24.0 : 12.0,
              decoration: BoxDecoration(
                color: atual ? ThemeBase.color : Colors.grey,
                borderRadius: BorderRadius.circular(90.0),
              ),
              duration: Duration(
                seconds: (widget.durationTransition * .5).toInt(),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
