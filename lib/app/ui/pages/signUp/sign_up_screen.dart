import 'package:cafe_gourmet/app/controllers/sign_in_controller.dart';
import 'package:cafe_gourmet/app/controllers/sign_up_controller.dart';
import 'package:cafe_gourmet/app/ui/global_widgets/button.dart';
import 'package:cafe_gourmet/app/ui/global_widgets/scaffold.dart';
import 'package:cafe_gourmet/app/ui/global_widgets/textformfield.dart';
import 'package:cafe_gourmet/app/ui/theme/theme.dart';
import 'package:cafe_gourmet/app/ui/utils/alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final controller = Get.put(SignUpController());
  final SignInController signInController = Get.find();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
    );
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
          title: 'Nome Completo',
          colorBackground: Colors.white30,
          colorText: Colors.white,
          colorDecoration: Colors.white,
          textAlign: TextAlign.center,
          onChanged: controller.setNome,
          margin: EdgeInsets.symmetric(
            horizontal: Get.size.width * .07,
            vertical: 5.0,
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
    return Obx(() => Column(
          children: [
            WButton(
              text: 'Criar nova conta',
              loading: controller.atualizando,
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
                } else if (controller.senha.length < 8) {
                  Alerts().errorSnackbar(
                    'Campo senha é obrigatório 8 ou mais caracteres!',
                  );
                  return;
                }

                final response = await controller.createLoginEmail();
                if (response) {
                  Get.back();
                  Alerts().sucessSnackbar('Conta criada com sucesso!');
                }
              },
              colorBackground: ThemeBase.color,
              colorText: Colors.white,
              fontSize: 18.0,
              size: Size(
                Get.size.width * .85,
                Get.size.height * .06,
              ),
              margin: const EdgeInsets.only(top: 30.0),
            ),
            Divider(
              color: Colors.white70,
              endIndent: Get.size.width * .13,
              indent: Get.size.width * .13,
              height: Get.size.height * .12,
            ),
            WButton(
              loading: signInController.atualizandoGoogle,
              iconLeft: FontAwesomeIcons.google,
              colorIconLeft: Colors.white,
              sizeIconLeft: 22.0,
              fontSize: 18.0,
              spacingIconLeft: const EdgeInsets.only(
                left: 30.0,
              ),
              text: 'Entrar com Google',
              onSelect: signInController.loginGoogle,
              colorBackground: Colors.red,
              colorSecundary: Colors.red,
              colorText: Colors.white,
              size: Size(
                Get.size.width * .85,
                Get.size.height * .06,
              ),
            ),
            Image.asset(
              ThemeBase.imageBrandingPath,
              height: Get.size.height * .15,
            ),
          ],
        ));
  }
}
