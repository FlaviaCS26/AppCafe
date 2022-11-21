import 'package:cafe_gourmet/app/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WButton extends StatefulWidget {
  final String text;
  final Function()? onSelect;
  final Color colorBackground;
  final Color colorSecundary;
  final Color colorText;
  final double fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Size? size;
  final IconData? iconLeft;
  final bool loading;
  final Color colorLoading;
  final double sizeLoading;
  final Color? colorIconLeft;
  final double? sizeIconLeft;
  final EdgeInsetsGeometry spacingIconLeft;
  final double elevation;

  const WButton({
    super.key,
    required this.text,
    this.onSelect,
    this.size,
    this.iconLeft,
    this.colorIconLeft,
    this.sizeIconLeft,
    this.fontWeight,
    this.elevation = 0.0,
    this.loading = false,
    this.colorLoading = Colors.white70,
    this.sizeLoading = 25.0,
    this.fontSize = 17.0,
    this.spacingIconLeft = const EdgeInsets.symmetric(horizontal: 8.0),
    this.colorBackground = ThemeBase.color,
    this.colorText = Colors.white,
    this.colorSecundary = Colors.white,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
  });

  @override
  State<WButton> createState() => _WButtonState();
}

class _WButtonState extends State<WButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: ElevatedButton(
        onPressed: () {
          if (!widget.loading && widget.onSelect != null) widget.onSelect!();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(widget.colorBackground),
          overlayColor: MaterialStateProperty.all(
            isColorSecundary.withOpacity(.1),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(90.0),
              side: BorderSide(color: isColorSecundary, width: 0.75),
            ),
          ),
          elevation: MaterialStateProperty.all(widget.elevation),
          minimumSize: MaterialStateProperty.all(widget.size),
          maximumSize: MaterialStateProperty.all(widget.size),
        ),
        child: Padding(
          padding: widget.padding,
          child: body(),
        ),
      ),
    );
  }

  Widget body() {
    if (widget.loading) {
      return Center(
        child: SpinKitFadingCircle(
          color: widget.colorLoading,
          size: widget.sizeLoading,
        ),
      );
    } else {
      return Row(
        children: [
          if (widget.iconLeft != null)
            Padding(
              padding: widget.spacingIconLeft,
              child: FaIcon(
                widget.iconLeft,
                color: widget.colorIconLeft,
                size: widget.sizeIconLeft,
              ),
            ),
          Expanded(
            child: Center(
              child: Text(
                widget.text,
                style: TextStyle(
                  fontSize: widget.fontSize,
                  color: widget.colorText,
                  fontWeight: widget.fontWeight,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  Color get isColorSecundary {
    if (widget.colorSecundary == Colors.white) {
      if (widget.colorBackground == ThemeBase.color) {
        return Colors.white;
      } else if (widget.colorBackground == Colors.white) {
        return ThemeBase.color;
      }
    }
    return widget.colorSecundary;
  }
}
