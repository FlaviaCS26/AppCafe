import 'package:cafe_gourmet/app/controllers/carrinho_controller.dart';
import 'package:cafe_gourmet/app/data/models/carrinho_model.dart';
import 'package:cafe_gourmet/app/data/models/produto_model.dart';
import 'package:cafe_gourmet/app/ui/global_widgets/scaffold_detail.dart';
import 'package:cafe_gourmet/app/ui/pages/product/widgets/bottom_screen.dart';
import 'package:cafe_gourmet/app/ui/pages/product/widgets/center_screen.dart';
import 'package:cafe_gourmet/app/ui/utils/alerts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductScreen extends StatefulWidget {
  final ProdutoModel model;
  final CarrinhoModel? carrinho;
  const ProductScreen({
    super.key,
    required this.model,
    this.carrinho,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final CarrinhoController controller = Get.find();
  late ValoresProdutoModel select;
  int qtde = 0;
  double value = 0;
  bool processando = false;

  @override
  void initState() {
    if (widget.carrinho != null) {
      qtde = widget.carrinho!.qtde;
      select = widget.model.valores.firstWhere(
        (e) => e.descricao == widget.carrinho!.modelo,
      );
      setValue();
    } else {
      select = widget.model.valores.first;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WScaffoldDetail(
      onPop: !processando,
      title: 'Detalhes do Item',
      child: Column(
        children: [
          CenterScreenProduct(
            model: widget.model,
            value: value,
            select: select,
            onSelect: (e) {
              select = e;
              setValue();
            },
          ),
          BottomScreenProduct(
            processando: processando,
            insert: widget.carrinho == null,
            qtde: qtde,
            onChanged: (v) {
              qtde = v;
              setValue();
            },
            onSelect: processamentoItem,
          ),
        ],
      ),
    );
  }

  Future<void> processamentoItem() async {
    if (qtde > 0) {
      setState(() => processando = true);
      if (widget.carrinho != null) {
        final c = widget.carrinho!;
        if (c.modelo != select.descricao) {
          ///quando usuário muda modelo do item
          await controller.deleteItem(c);
          await insertItemCarrinho();
        } else {
          if (c.qtde != qtde) {
            ///quando altera quantidade do item
            await updateItemCarrinho();
          } else {
            ///quando não encontra nenhuma alteração
            setState(() => processando = false);
            Get.offAndToNamed('/carrinho');
          }
        }
      } else {
        ///quando insere item novo
        await insertItemCarrinho();
      }
    } else {
      Alerts().warningSnackbar(
        'É necessário informar quantidade!',
      );
    }
  }

  Future<void> insertItemCarrinho() async {
    final c = CarrinhoModel.fromNew(widget.model, select.descricao, qtde);
    c.setValorUnitario(select.valor);
    final response = await controller.insertItem(c);
    setState(() => processando = false);
    if (response) {
      Get.offAndToNamed('/carrinho');
    } else {
      Alerts().errorSnackbar(
        'Não foi possível inserir no carrinho!',
      );
    }
  }

  Future<void> updateItemCarrinho() async {
    final c = widget.carrinho!;
    c.setQtde(qtde);
    final response = await controller.updateItem(c);
    setState(() => processando = false);
    if (response) {
      Get.offAndToNamed('/carrinho');
    } else {
      Alerts().errorSnackbar(
        'Não foi possível inserir no carrinho!',
      );
    }
  }

  setValue() {
    value = select.valor * qtde;
    setState(() {});
  }
}
