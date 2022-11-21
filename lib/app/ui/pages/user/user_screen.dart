import 'package:cafe_gourmet/app/controllers/home_controller.dart';
import 'package:cafe_gourmet/app/controllers/sign_in_controller.dart';
import 'package:cafe_gourmet/app/data/models/usuario_model.dart';
import 'package:cafe_gourmet/app/ui/global_widgets/button.dart';
import 'package:cafe_gourmet/app/ui/global_widgets/scaffold.dart';
import 'package:cafe_gourmet/app/ui/pages/user/widgets/buttons_user.dart';
import 'package:cafe_gourmet/app/ui/pages/user/widgets/info_user.dart';
import 'package:cafe_gourmet/app/ui/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final HomeController homeController = Get.find();
  final controller = Get.put(SignInController());
  late UsuarioModel model;
  late User user;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    user = FirebaseAuth.instance.currentUser!;
    model = UsuarioModel.fromUser(user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WScaffold(
      colorBackground: Colors.grey[100]!,
      bottomsNavigationBar: true,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            topScreen(),
            const Expanded(child: ButtonsUser()),
            buttonLogout(),
          ],
        ),
      ),
    );
  }

  Widget topScreen() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: FaIcon(
                  FontAwesomeIcons.solidUser,
                  color: ThemeBase.color,
                  size: 19.0,
                ),
              ),
              Text(
                'Meu Perfil',
                style: TextStyle(
                  color: ThemeBase.color,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        InfoUserScreen(model: model),
      ],
    );
  }

  Widget buttonLogout() {
    return WButton(
      margin: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 20.0,
      ),
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      text: 'Sair da Conta',
      onSelect: controller.logoff,
    );
  }
}
