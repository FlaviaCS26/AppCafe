import 'package:cafe_gourmet/app/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class WDStarRating extends StatelessWidget {
  final double value;
  final bool enabled;
  final EdgeInsetsGeometry margin;
  final Function(double v) onChanged;
  final double sizeStar;
  final double spacingStars;
  final Color? colorStars;

  const WDStarRating({
    Key? key,
    required this.value,
    required this.onChanged,
    this.margin = EdgeInsets.zero,
    this.enabled = true,
    this.sizeStar = 20.0,
    this.spacingStars = 1.0,
    this.colorStars,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: RatingStars(
        value: value,
        onValueChanged: enabled ? onChanged : null,
        starBuilder: (index, color) => Icon(
          Icons.star,
          color: color,
          size: sizeStar,
        ),
        starCount: 5,
        starSize: sizeStar * 1.2,
        valueLabelColor: const Color(0xff9b9b9b),
        valueLabelTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 17.0,
        ),
        valueLabelRadius: 10,
        maxValue: 5,
        starSpacing: spacingStars,
        maxValueVisibility: false,
        valueLabelVisibility: false,
        animationDuration: const Duration(
          milliseconds: 1000,
        ),
        valueLabelPadding: const EdgeInsets.symmetric(
          vertical: 1,
          horizontal: 8,
        ),
        valueLabelMargin: const EdgeInsets.only(right: 8),
        starOffColor: const Color(0xffe7e8ea),
        starColor: colorStars ?? ThemeBase.color,
      ),
    );
  }
}
