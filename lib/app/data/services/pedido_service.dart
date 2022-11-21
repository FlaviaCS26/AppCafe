import 'package:cafe_gourmet/app/data/models/pedido_model.dart';
import 'package:cafe_gourmet/app/data/models/usuario_model.dart';
import 'package:firebase_database/firebase_database.dart';

class PedidoService {
  final UsuarioModel model;
  late DatabaseReference ref;
  PedidoService(this.model) {
    ref = FirebaseDatabase.instance.ref().child('Pedidos').child(model.uid);
  }

  Future<List<PedidoModel>> getPedidos() async {
    List<PedidoModel> response = [];
    final s = await ref.get();
    if (s.exists) {
      for (var e in (s.value as Map<Object?, Object?>).entries) {
        final values = e.value as Map;
        values['id'] = e.key;
        response.add(PedidoModel.fromJson(values));
      }
    }
    return response;
  }

  Future<PedidoModel?> getPedidoByRef(String r) async {
    final s = await ref.child(r).get();
    if (s.exists) {
      Map response = s.value as Map;
      response['id'] = r;
      return PedidoModel.fromJson(response);
    }
    return null;
  }

  Future<PedidoModel?> insertPedido(PedidoModel c) async {
    await ref.child(c.id).set(c.toJson());
    return await getPedidoByRef(c.id);
  }

  Future<PedidoModel?> updatePedido(PedidoModel c) async {
    await ref.child(c.id).update(c.toJson());
    return await getPedidoByRef(c.id);
  }

  Future<bool> deletePedido(String r) async {
    await ref.child(r).remove();
    final response = await getPedidoByRef(r);
    return response == null;
  }
}
