import 'package:cafe_gourmet/app/controllers/sign_in_controller.dart';
import 'package:cafe_gourmet/app/ui/global_widgets/button.dart';
import 'package:cafe_gourmet/app/ui/global_widgets/scaffold.dart';
import 'package:cafe_gourmet/app/ui/global_widgets/textformfield.dart';
import 'package:cafe_gourmet/app/ui/pages/signUp/sign_up_screen.dart';
import 'package:cafe_gourmet/app/ui/theme/theme.dart';
import 'package:cafe_gourmet/app/ui/utils/alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late SignInController controller;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    controller = Get.put(SignInController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WScaffold(
      isImageBackground: true,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              textFormFields(),
              buttons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget textFormFields() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: Get.size.height * .03,
          ),
          child: Image.asset(
            ThemeBase.imageIconeBrancoPath,
            width: Get.size.width * .5,
            color: Colors.white,
            fit: BoxFit.cover,
          ),
        ),
        WDTextField(
          title: 'E-mail',
          colorBackground: Colors.white30,
          colorText: Colors.white,
          colorDecoration: Colors.white,
          textAlign: TextAlign.center,
          onChanged: controller.setEmail,
          margin: EdgeInsets.symmetric(
            horizontal: Get.size.width * .07,
            vertical: 5.0,
          ),
        ),
        WDTextField(
          title: 'Senha',
          colorBackground: Colors.white24,
          colorText: Colors.white,
          colorDecoration: Colors.white,
          textAlign: TextAlign.center,
          isPassword: true,
          onChanged: controller.setSenha,
          margin: EdgeInsets.symmetric(
            horizontal: Get.size.width * .07,
            vertical: 5.0,
          ),
        ),
      ],
    );
  }

  Widget buttons() {
    return Column(
      children: [
        Obx(() => WButton(
              text: 'Entrar na Conta',
              loading: controller.atualizandoEmail,
              onSelect: () async {
                if (controller.email.isEmpty || !controller.email.isEmail) {
                  Alerts().errorSnackbar(
                    'Campo e-mail está inválido!',
                  );
                  return;
                } else if (controller.senha.isEmpty) {
                  Alerts().errorSnackbar(
                    'É preciso preencher senha!',
                  );
                  return;
                }

                await controller.loginEmail();
              },
              colorBackground: ThemeBase.color,
              colorText: Colors.white,
              fontSize: 18.0,
              size: Size(
                Get.size.width * .85,
                Get.size.height * .06,
              ),
              margin: const EdgeInsets.only(
                top: 30.0,
              ),
            )),
        Divider(
          color: Colors.white70,
          endIndent: Get.size.width * .13,
          indent: Get.size.width * .13,
          height: Get.size.height * .12,
        ),
        Obx(() => WButton(
              loading: controller.atualizandoGoogle,
              iconLeft: FontAwesomeIcons.google,
              colorIconLeft: Colors.white,
              sizeIconLeft: 22.0,
              fontSize: 18.0,
              spacingIconLeft: const EdgeInsets.only(
                left: 30.0,
              ),
              text: 'Entrar com Google',
              onSelect: controller.loginGoogle,
              colorBackground: Colors.red,
              colorSecundary: Colors.red,
              colorText: Colors.white,
              size: Size(
                Get.size.width * .85,
                Get.size.height * .06,
              ),
            )),
        Padding(
          padding: EdgeInsets.only(
            top: Get.size.height * .09,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Ainda não tem conta? ',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16.0,
                ),
              ),
              InkWell(
                onTap: () => Get.to(
                  () => const SignUpScreen(),
                  transition: Transition.cupertino,
                ),
                child: const Text(
                  'Clique Aqui',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Image.asset(
          ThemeBase.imageBrandingPath,
          height: Get.size.height * .15,
        ),
      ],
    );
  }
}
