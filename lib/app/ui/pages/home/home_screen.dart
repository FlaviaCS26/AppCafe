import 'package:cafe_gourmet/app/bindings/bindings_global.dart';
import 'package:cafe_gourmet/app/controllers/home_controller.dart';
import 'package:cafe_gourmet/app/data/models/usuario_model.dart';
import 'package:cafe_gourmet/app/ui/global_widgets/scaffold.dart';
import 'package:cafe_gourmet/app/ui/pages/home/widgets/category_select.dart';
import 'package:cafe_gourmet/app/ui/pages/home/widgets/promotions.dart';
import 'package:cafe_gourmet/app/ui/pages/home/widgets/recommendation.dart';
import 'package:cafe_gourmet/app/ui/pages/home/widgets/textform_search.dart';
import 'package:cafe_gourmet/app/ui/pages/home/widgets/user_logado.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeController controller;
  late UsuarioModel model;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    model = UsuarioModel.fromUser(
      FirebaseAuth.instance.currentUser!,
    );
    GlobalBinding(model).dependencies();
    controller = Get.find();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WScaffold(
      colorBackground: Colors.grey[100]!,
      bottomsNavigationBar: true,
      child: Obx(() => body()),
    );
  }

  Widget body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: UserLogadoHomeScreen(
              model: model,
            ),
          ),
          WTextFieldSearchHomeScreen(
            onChanged: (v) {},
            onPressed: () {},
          ),
          CategorySelectHomeScreen(
            listagem: controller.categorias,
            atualizando: controller.atualizando,
            isSelect: controller.categoriaSelect,
            onSelect: controller.setCategoria,
          ),
          Expanded(
            child: PromotionsHomeScreen(
              images: controller.promocoes,
              atualizando: controller.atualizando,
            ),
          ),
          RecommendationHomeScreen(
            produtos: controller.produtosRecomendacaoFilter,
            categoria: controller.categoriaSelect?.descricao ?? '',
            atualizando: controller.atualizando,
          ),
        ],
      ),
    );
  }
}
