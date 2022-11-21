import 'package:cafe_gourmet/app/data/models/usuario_model.dart';
import 'package:cafe_gourmet/app/ui/global_widgets/image_network.dart';
import 'package:cafe_gourmet/app/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoUserScreen extends StatelessWidget {
  final UsuarioModel model;
  const InfoUserScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeBase.color.withOpacity(.1),
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 35.0,
      ),
      child: SizedBox(
        width: Get.size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.size.width * .3,
              width: Get.size.width * .3,
              child: imageUser(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 2.0),
                    child: Text(
                      model.name,
                      style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    model.email,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageUser() {
    if (model.imageUrl.isNotEmpty) {
      return WImageNetwork(
        url: model.imageUrl,
        borderRadius: 90.0,
        fit: BoxFit.cover,
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
}
