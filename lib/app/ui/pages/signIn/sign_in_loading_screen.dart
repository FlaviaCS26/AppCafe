import 'package:cafe_gourmet/app/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class SignInLoading extends StatelessWidget {
  const SignInLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeBase.color,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: Get.size.height * .06,
                ),
                child: Image.asset(
                  ThemeBase.imageIconeBrancoPath,
                  width: Get.size.width * .48,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: Get.size.height * .18),
                child: const SpinKitFadingCircle(
                  color: Colors.white70,
                  size: 30.0,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                ThemeBase.imageBrandingPath,
                width: Get.size.width * .8,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
