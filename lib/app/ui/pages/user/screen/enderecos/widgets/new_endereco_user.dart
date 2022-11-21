import 'package:cafe_gourmet/app/controllers/user_controller.dart';
import 'package:cafe_gourmet/app/data/models/endereco_model.dart';
import 'package:cafe_gourmet/app/ui/global_widgets/button.dart';
import 'package:cafe_gourmet/app/ui/global_widgets/scaffold_detail.dart';
import 'package:cafe_gourmet/app/ui/global_widgets/textformfield.dart';
import 'package:cafe_gourmet/app/ui/theme/theme.dart';
import 'package:cafe_gourmet/app/ui/utils/alerts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewEnderecoUser extends StatefulWidget {
  final EnderecoModel? model;
  const NewEnderecoUser({super.key, this.model});

  @override
  State<NewEnderecoUser> createState() => _NewEnderecoUserState();
}

class _NewEnderecoUserState extends State<NewEnderecoUser> {
  final UserController controller = Get.find();
  bool novo = true;
  late EnderecoModel m;

  @override
  void initState() {
    if (widget.model != null) {
      m = widget.model!;
      novo = false;
    } else {
      m = EnderecoModel.fromNew();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => WScaffoldDetail(
          title: '${novo ? 'Cadastrar Novo' : 'Editar'} Endereço',
          initColorStatus: false,
          disposeColorStatus: false,
          onPop: !controller.atualizando,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: campos(),
                ),
                button(),
              ],
            ),
          ),
        ));
  }

  Widget campos() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: Get.size.height * .78,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          grupoContato(),
          grupoEndereco(),
        ],
      ),
    );
  }

  Widget grupoContato() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text(
            'Contato',
            style: TextStyle(
              color: Colors.white54,
            ),
          ),
        ),
        textForm(
          initialText: m.nomeContato,
          title: 'Nome Completo',
          onChanged: m.setNomeContato,
        ),
        textForm(
          initialText: m.telefoneContato,
          title: 'Número de Telefone',
          onChanged: m.setTelefoneContato,
        ),
      ],
    );
  }

  Widget grupoEndereco() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 30.0, bottom: 8.0),
          child: Text(
            'Endereço',
            style: TextStyle(
              color: Colors.white54,
            ),
          ),
        ),
        SizedBox(
          width: Get.size.width * .4,
          child: textForm(
            initialText: m.cep,
            title: 'CEP',
            onChanged: m.setCep,
          ),
        ),
        textForm(
          initialText: m.estado,
          title: 'Estado',
          onChanged: m.setEstado,
        ),
        textForm(
          initialText: m.cidade,
          title: 'Cidade',
          onChanged: m.setCidade,
        ),
        textForm(
          initialText: m.bairro,
          title: 'Bairro',
          onChanged: m.setBairro,
        ),
        textForm(
          initialText: m.nomeRua,
          title: 'Nome da Rua',
          onChanged: m.setNomeRua,
        ),
        SizedBox(
          width: Get.size.width * .4,
          child: textForm(
            initialText: m.numero,
            title: 'Número',
            onChanged: m.setNumero,
          ),
        ),
        textForm(
          initialText: m.complemento,
          title: 'Complemento',
          onChanged: m.setComplemento,
        ),
      ],
    );
  }

  Widget textForm({
    required String initialText,
    required String title,
    required Function(String v) onChanged,
  }) {
    return WDTextField(
      initialText: initialText,
      colorBackground: Colors.black12,
      colorText: Colors.white.withOpacity(.85),
      colorHint: Colors.white38,
      colorDecoration: Colors.white54,
      filled: true,
      title: title,
      hint: 'Digite ${title.toLowerCase()}',
      onChanged: onChanged,
      margin: const EdgeInsets.symmetric(vertical: 5),
    );
  }

  Widget button() {
    return WButton(
      colorBackground: Colors.white,
      colorText: ThemeBase.color,
      padding: const EdgeInsets.symmetric(
        vertical: 7.0,
      ),
      text: 'Salvar',
      loading: controller.atualizando,
      onSelect: () async {
        if (m.nomeContato.isEmpty) {
          Alerts().warningSnackbar(
            'Campo NOME COMPLETO DO CONTATO é obrigatório!',
          );
          return;
        } else if (m.telefoneContato.isEmpty) {
          Alerts().warningSnackbar(
            'Campo TELEFONE DO CONTATO é obrigatório!',
          );
          return;
        } else if (m.cep.isEmpty) {
          Alerts().warningSnackbar(
            'Campo CEP é obrigatório!',
          );
          return;
        } else if (m.nomeRua.isEmpty) {
          Alerts().warningSnackbar(
            'Campo NOME DA RUA é obrigatório!',
          );
          return;
        } else if (m.numero.isEmpty) {
          Alerts().warningSnackbar(
            'Campo NÚMERO é obrigatório!',
          );
          return;
        } else if (m.bairro.isEmpty) {
          Alerts().warningSnackbar(
            'Campo BAIRRO é obrigatório!',
          );
          return;
        } else if (m.cidade.isEmpty) {
          Alerts().warningSnackbar(
            'Campo CIDADE é obrigatório!',
          );
          return;
        } else if (m.estado.isEmpty) {
          Alerts().warningSnackbar(
            'Campo ESTADO é obrigatório!',
          );
          return;
        }

        late bool response;
        if (novo) {
          response = await controller.insertEndereco(m);
        } else {
          response = await controller.updateEndereco(m);
        }

        if (response) Get.back();
      },
    );
  }
}
