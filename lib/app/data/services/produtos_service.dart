import 'package:cafe_gourmet/app/data/models/produto_model.dart';
import 'package:firebase_database/firebase_database.dart';

class ProdutosService {
  final ref = FirebaseDatabase.instance.ref();

  Future<List<ProdutoModel>> getProdutos() async {
    List<ProdutoModel> response = [];
    final s = await ref.child('Produtos').get();
    if (s.exists) {
      final r = List<Map>.from(s.value as List<Object?>);
      response.addAll(
        r.map((e) {
          final index = r.indexOf(e);
          e['id'] = index;
          return ProdutoModel.fromJson(e);
        }).toList(),
      );
    }
    return response;
  }
}
