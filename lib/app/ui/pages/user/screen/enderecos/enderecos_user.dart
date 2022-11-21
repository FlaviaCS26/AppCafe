import 'package:cafe_gourmet/app/controllers/user_controller.dart';
import 'package:cafe_gourmet/app/ui/global_widgets/scaffold_detail.dart';
import 'package:cafe_gourmet/app/ui/pages/user/screen/enderecos/widgets/card_item.dart';
import 'package:cafe_gourmet/app/ui/pages/user/screen/enderecos/widgets/new_endereco_user.dart';
import 'package:cafe_gourmet/app/ui/utils/alerts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class EnderecosUsersScreen extends StatefulWidget {
  const EnderecosUsersScreen({super.key});

  @override
  State<EnderecosUsersScreen> createState() => _EnderecosUsersScreenState();
}

class _EnderecosUsersScreenState extends State<EnderecosUsersScreen> {
  final UserController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return WScaffoldDetail(
      title: 'Meus Endereços',
      rWidget: InkWell(
        onTap: () => Get.to(
          () => const NewEnderecoUser(),
          transition: Transition.cupertino,
        ),
        hoverColor: Colors.white.withOpacity(.15),
        splashColor: Colors.white.withOpacity(.2),
        highlightColor: Colors.white.withOpacity(.25),
        borderRadius: BorderRadius.circular(90.0),
        child: const Padding(
          padding: EdgeInsets.all(5.0),
          child: FaIcon(
            FontAwesomeIcons.plus,
            color: Colors.white,
            size: 18.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: body(),
      ),
    );
  }

  Widget body() {
    return Obx(() => ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: controller.listagem.length,
          itemBuilder: (c, i) {
            final m = controller.listagem[i];
            return CardItemEnderecosUsersScreen(
              m: m,
              onDelete: () async {
                if (await Alerts().questionSnackbar(
                  'Deseja excluir o endereço selecionado?',
                )) {
                  await controller.deleteEndereco(m);
                }
              },
            );
          },
        ));
  }
}
