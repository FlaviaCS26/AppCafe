import 'package:flutter/material.dart';

class ThemeBase {
  static const Map<int, Color> listColor = {
    50: Color.fromRGBO(8, 105, 113, .1),
    100: Color.fromRGBO(8, 105, 113, .2),
    200: Color.fromRGBO(8, 105, 113, .3),
    300: Color.fromRGBO(8, 105, 113, .4),
    400: Color.fromRGBO(8, 105, 113, .5),
    500: Color.fromRGBO(8, 105, 113, .6),
    600: Color.fromRGBO(8, 105, 113, .7),
    700: Color.fromRGBO(8, 105, 113, .8),
    800: Color.fromRGBO(8, 105, 113, .9),
    900: Color.fromRGBO(8, 105, 113, 1),
  };
  static const int colorInt = 0xFF086971;
  static const MaterialColor colorMaterial = MaterialColor(colorInt, listColor);
  static const Color color = Color(colorInt);

  ///Tema padrão do app
  static ThemeData theme() {
    return ThemeData(
      primarySwatch: colorMaterial,
    );
  }
  
  static const String imageIconeBrancoPath = 'assets/icone_branco.png';
  static const ImageProvider imageIconeBranco = ExactAssetImage(imageIconeBrancoPath);
  static const String imageBrandingPath = 'assets/branding.png';
  static const ImageProvider imageBranding = ExactAssetImage(imageBrandingPath);
}
