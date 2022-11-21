import 'package:cafe_gourmet/app/data/models/categoria_model.dart';
import 'package:firebase_database/firebase_database.dart';

class CategoriasService {
  final ref = FirebaseDatabase.instance.ref();

  Future<List<CategoriaModel>> getCategorias() async {
    List<CategoriaModel> response = [];
    final s = await ref.child('Categorias').get();
    if (s.exists) {
      final r = List<Map>.from(s.value as List<Object?>);
      response.addAll(
        r.map((e) {
          final index = r.indexOf(e);
          e['id'] = index;
          return CategoriaModel.fromJson(e);
        }).toList(),
      );
    }
    return response;
  }
}
