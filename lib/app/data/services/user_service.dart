import 'package:cafe_gourmet/app/data/models/endereco_model.dart';
import 'package:cafe_gourmet/app/data/models/usuario_model.dart';
import 'package:firebase_database/firebase_database.dart';

class UserService {
  final UsuarioModel model;
  late DatabaseReference ref;
  UserService(this.model) {
    ref = FirebaseDatabase.instance.ref().child('Usuários').child(model.uid);
  }

  Future<List<EnderecoModel>> getEnderecos() async {
    List<EnderecoModel> response = [];
    final s = await ref.child('Endereços').get();
    if (s.exists) {
      for (var e in (s.value as Map<Object?, Object?>).entries) {
        final values = e.value as Map;
        values['id'] = e.key;
        response.add(EnderecoModel.fromJson(values));
      }
    }
    return response;
  }

  Future<EnderecoModel?> getEnderecoByRef(String r) async {
    final s = await ref.child('Endereços').child(r).get();
    if (s.exists) {
      Map response = s.value as Map;
      response['id'] = r;
      return EnderecoModel.fromJson(response);
    }
    return null;
  }

  Future<EnderecoModel?> insertEndereco(EnderecoModel c) async {
    await ref.child('Endereços').child(c.id).set(c.toJson());
    return await getEnderecoByRef(c.id);
  }

  Future<EnderecoModel?> updateEndereco(EnderecoModel c) async {
    await ref.child('Endereços').child(c.id).update(c.toJson());
    return await getEnderecoByRef(c.id);
  }

  Future<bool> deleteEndereco(String r) async {
    await ref.child('Endereços').child(r).remove();
    final response = await getEnderecoByRef(r);
    return response == null;
  }
}
