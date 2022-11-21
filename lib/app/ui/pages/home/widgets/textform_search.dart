import 'package:cafe_gourmet/app/ui/global_widgets/textformfield.dart';
import 'package:cafe_gourmet/app/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WTextFieldSearchHomeScreen extends StatelessWidget {
  final Function(String v) onChanged;
  final Function() onPressed;
  final EdgeInsetsGeometry margin;
  final String hint;
  final double sizeButton;

  const WTextFieldSearchHomeScreen({
    super.key,
    required this.onChanged,
    required this.onPressed,
    this.hint = 'Faça sua busca aqui...',
    this.margin = const EdgeInsets.symmetric(vertical: 10.0),
    this.sizeButton = 55.0,
  });

  @override
  Widget build(BuildContext context) {
    return WDTextField(
      colorBackground: Colors.grey.withOpacity(.2),
      colorDecoration: Colors.grey[200]!,
      colorCursor: ThemeBase.color,
      colorHint: Colors.grey,
      hint: hint,
      margin: margin,
      rightWd: SizedBox(
        width: sizeButton,
        height: sizeButton,
        child: IconButton(
          splashColor: Colors.transparent,
          onPressed: onPressed,
          icon: const CircleAvatar(
            radius: 70.0,
            backgroundColor: Colors.white,
            child: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              size: 13.0,
            ),
          ),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
