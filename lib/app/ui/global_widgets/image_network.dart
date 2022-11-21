import 'package:cached_network_image/cached_network_image.dart';
import 'package:cafe_gourmet/app/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class WImageNetwork extends StatelessWidget {
  final String url;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry margin;
  final BoxFit? fit;
  final double borderRadius;

  const WImageNetwork({
    super.key,
    required this.url,
    this.margin = EdgeInsets.zero,
    this.height,
    this.width,
    this.fit,
    this.borderRadius = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: CachedNetworkImage(
        imageUrl: url,
        height: height,
        width: width,
        fit: fit,
        imageBuilder: (c, i) {
          return Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              image: DecorationImage(image: i, fit: fit),
            ),
          );
        },
        progressIndicatorBuilder: (c, u, d) {
          return Center(
            child: SizedBox(
              height: height ?? 60 * .3,
              width: height ?? 60 * .3,
              child: CircularProgressIndicator(
                color: ThemeBase.color,
                value: d.progress,
              ),
            ),
          );
        },
        errorWidget: (c, u, e) => const Center(
          child: Icon(Icons.error, color: Colors.red),
        ),
      ),
    );
  }
}
