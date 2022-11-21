import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoriaModel {
  late int id;
  late String descricao;
  late IconData icone;

  CategoriaModel.fromJson(Map json) {
    id = json['id'];
    descricao = json['descricao'];
    icone = IconDataSolid(
      int.parse(json['icone'].toString()),
    );
  }
}
