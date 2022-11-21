import 'package:cafe_gourmet/app/data/models/carrinho_model.dart';
import 'package:cafe_gourmet/app/data/models/usuario_model.dart';
import 'package:firebase_database/firebase_database.dart';

class CarrinhoService {
  final UsuarioModel model;
  late DatabaseReference ref;
  CarrinhoService(this.model) {
    ref = FirebaseDatabase.instance.ref().child('Carrinho').child(model.uid);
  }

  Future<List<CarrinhoModel>> getCarrinho() async {
    List<CarrinhoModel> response = [];
    final s = await ref.get();
    if (s.exists) {
      for (var e in (s.value as Map<Object?, Object?>).entries) {
        final values = e.value as Map;
        values['id'] = e.key;
        response.add(CarrinhoModel.fromJson(values));
      }
    }
    return response;
  }

  Future<CarrinhoModel?> getCarrinhoByRef(String r) async {
    final s = await ref.child(r).get();
    if (s.exists) {
      Map response = s.value as Map;
      response['id'] = r;
      return CarrinhoModel.fromJson(response);
    }
    return null;
  }

  Future<CarrinhoModel?> insertCarrinho(CarrinhoModel c) async {    
    await ref.child(c.id).set(c.toJson());
    return await getCarrinhoByRef(c.id);
  }

  Future<CarrinhoModel?> updateCarrinho(CarrinhoModel c) async {
    await ref.child(c.id).update(c.toJson());
    return await getCarrinhoByRef(c.id);
  }

  Future<bool> deleteCarrinho(String r) async {
    await ref.child(r).remove();
    final response = await getCarrinhoByRef(r);
    return response == null;
  }

  Future<void> deleteAllCarrinho() async {
    await ref.remove();
  }
}
