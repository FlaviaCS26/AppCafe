import 'package:cafe_gourmet/app/data/models/promocao_model.dart';
import 'package:firebase_database/firebase_database.dart';

class PromocoesService {
  final ref = FirebaseDatabase.instance.ref().child('Promoções');

  Future<List<PromocaoModel>> getPromocoes() async {
    List<PromocaoModel> response = [];
    final s = await ref.get();
    if (s.exists) {
      final r = List<Map>.from(s.value as List<Object?>);
      response.addAll(
        r.map((e) {
          final index = r.indexOf(e);
          e['id'] = index;
          return PromocaoModel.fromJson(e);
        }).toList(),
      );
    }
    return response;
  }
}
