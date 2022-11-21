import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FormaPagamentoModel {
  late int id;
  late String descricao;
  late String icone;
  late IconData iconeData;

  FormaPagamentoModel.fromJson(Map json) {
    id = json['id'];
    descricao = json['descricao'];
    icone = json['icone'];
    switch (icone.split('_').last) {
      case 'b':
        iconeData = IconDataBrands(
          int.parse(icone.split('_').first),
        );
        break;
      case 's':
        iconeData = IconDataSolid(
          int.parse(icone.split('_').first),
        );
        break;
      default:
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['descricao'] = descricao;
    data['icone'] = icone;
    return data;
  }
}
