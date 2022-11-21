import 'package:cafe_gourmet/app/data/models/forma_pagamento_model.dart';
import 'package:firebase_database/firebase_database.dart';

class FormasPagamentoService {
  final ref = FirebaseDatabase.instance.ref();

  Future<List<FormaPagamentoModel>> getFormasPagamento() async {
    List<FormaPagamentoModel> response = [];
    final s = await ref.child('FormasPagamento').get();
    if (s.exists) {
      final r = List<Map>.from(s.value as List<Object?>);
      response.addAll(
        r.map((e) {
          final index = r.indexOf(e);
          e['id'] = index;
          return FormaPagamentoModel.fromJson(e);
        }).toList(),
      );
    }
    return response;
  }
}
