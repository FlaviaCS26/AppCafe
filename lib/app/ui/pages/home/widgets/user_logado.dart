import 'package:cafe_gourmet/app/controllers/sign_in_controller.dart';
import 'package:cafe_gourmet/app/data/models/usuario_model.dart';
import 'package:cafe_gourmet/app/ui/global_widgets/image_network.dart';
import 'package:cafe_gourmet/app/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserLogadoHomeScreen extends StatelessWidget {
  final controller = Get.put(SignInController());

  final UsuarioModel model;
  final double sizeFont;
  final EdgeInsetsGeometry margin;

  UserLogadoHomeScreen({
    super.key,
    required this.model,
    this.margin = const EdgeInsets.symmetric(vertical: 10.0),
    this.sizeFont = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            saudacao,
            style: TextStyle(
              color: Colors.grey,
              fontSize: sizeFont,
            ),
          ),
          Text(
            '${model.firstName}!',
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
              fontSize: sizeFont,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
            ),
            child: GestureDetector(
              onTap: () => Get.toNamed('/perfil'),
              child: imageUser(),
            ),
          ),
        ],
      ),
    );
  }

  Widget imageUser() {
    if (model.imageUrl.isNotEmpty) {
      return WImageNetwork(
        url: model.imageUrl,
        borderRadius: 90.0,
        height: 40.0,
        width: 40.0,
      );
    }

    return CircleAvatar(
      backgroundColor: ThemeBase.color,
      child: Image.asset(
        ThemeBase.imageIconeBrancoPath,
        fit: BoxFit.contain,
      ),
    );
  }

  String get saudacao {
    final hrAtual = DateTime.now().hour;
    if (hrAtual < 12) return 'Bom dia, ';
    if (hrAtual < 18) return 'Boa tarde, ';
    return 'Boa noite, ';
  }
}
