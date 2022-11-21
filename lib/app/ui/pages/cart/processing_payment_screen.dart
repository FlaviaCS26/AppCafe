import 'package:cafe_gourmet/app/controllers/pedidos_controller.dart';
import 'package:cafe_gourmet/app/data/models/forma_pagamento_model.dart';
import 'package:cafe_gourmet/app/ui/global_widgets/scaffold.dart';
import 'package:cafe_gourmet/app/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProcessingPaymentScreen extends StatefulWidget {
  final FormaPagamentoModel model;
  const ProcessingPaymentScreen({super.key, required this.model});

  @override
  State<ProcessingPaymentScreen> createState() =>
      _ProcessingPaymentScreenState();
}

class _ProcessingPaymentScreenState extends State<ProcessingPaymentScreen> {
  final PedidosController controller = Get.find();
  bool? processingSucess;
  bool permitedBack = false;

  @override
  void initState() {
    processing();
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    super.dispose();
  }

  Future<void> processing() async {
    //fake tempo de processamento
    await Future.delayed(const Duration(seconds: 7));
    //processa solicitação
    final response = await controller.insertPedido(widget.model);
    setState(() => processingSucess = response);
    await Future.delayed(const Duration(seconds: 4), () {
      setState(() => permitedBack = true);
      Get.offAndToNamed('/pedidos');
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(permitedBack),
      child: WScaffold(
        colorBackground: processingSucess == null
            ? ThemeBase.color
            : processingSucess!
                ? Colors.green
                : Colors.red,
        isImageBackground: false,
        child: centerView(),
      ),
    );
  }

  Widget centerView() {
    if (processingSucess != null) {
      return Center(
        child: FaIcon(
          processingSucess!
              ? FontAwesomeIcons.solidCircleCheck
              : FontAwesomeIcons.solidCircleXmark,
          color: Colors.white54,
          size: Get.size.width * .35,
        ),
      );
    }

    return Stack(
      children: [
        Center(
          child: SizedBox(
            width: Get.size.width * .65,
            height: Get.size.width * .65,
            child: const CircularProgressIndicator(
              color: Colors.white54,
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                widget.model.iconeData,
                color: Colors.white38,
                size: Get.size.width * .08,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Text(
                  'Aguarde!\nEstamos processando\nseu pagamento...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white38,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
