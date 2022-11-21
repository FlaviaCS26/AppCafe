import 'package:cafe_gourmet/app/ui/global_widgets/button.dart';
import 'package:cafe_gourmet/app/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///Alertas do APP
class Alerts {
  Future<bool> questionSnackbar(String message) async {
    bool value = false;
    final controller = SnackbarController(
      GetSnackBar(
        duration: const Duration(seconds: 8),
        backgroundColor: ThemeBase.color,
        messageText: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 17.0),
              child: Row(
                children: [
                  WButton(
                    colorBackground: Colors.green,
                    onSelect: () {
                      value = true;
                      Get.back();
                    },
                    margin: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    text: 'Sim',
                    colorText: Colors.white,
                    size: Size(Get.size.width * .3, Get.size.width * .1),
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 10.0,
                    ),
                  ),
                  WButton(
                    colorBackground: Colors.red,
                    onSelect: () {
                      value = false;
                      Get.back();
                    },
                    margin: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    text: 'Não',
                    size: Size(Get.size.width * .3, Get.size.width * .1),
                    colorText: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 10.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    await controller.show();
    return value;
  }

  Future<void> sucessSnackbar(
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) async {
    final controller = SnackbarController(
      defaultSnackbar(
        colorBackground: Colors.green,
        message: message,
        duration: duration,
      ),
    );
    await controller.show();
  }

  Future<void> warningSnackbar(String message) async {
    final controller = SnackbarController(
      defaultSnackbar(
        colorBackground: Colors.orange,
        message: message,
        icone: Icons.warning_rounded,
      ),
    );
    await controller.show();
  }

  Future<void> errorSnackbar(
    String message, {
    Duration duration = const Duration(seconds: 7),
  }) async {
    final controller = SnackbarController(
      defaultSnackbar(
        colorBackground: Colors.red,
        message: message,
        duration: duration,
      ),
    );
    await controller.show();
  }

  GetSnackBar defaultSnackbar({
    required Color colorBackground,
    required String message,
    IconData? icone,
    Color colorText = Colors.white,
    Duration duration = const Duration(seconds: 2),
  }) {
    return GetSnackBar(
      duration: duration,
      backgroundColor: colorBackground,
      messageText: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icone != null)
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Icon(
                icone,
                color: colorText,
                size: 30.0,
              ),
            ),
          Expanded(
            child: Text(
              message,
              softWrap: true,
              maxLines: 50,
              style: TextStyle(
                color: colorText,
                fontSize: 15.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
