import 'package:cafe_gourmet/app/data/models/endereco_model.dart';
import 'package:cafe_gourmet/app/data/models/usuario_model.dart';
import 'package:cafe_gourmet/app/data/services/user_service.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final UsuarioModel model;
  late UserService service;

  UserController(this.model) {
    service = UserService(model);
    atualizarDados();
  }

  Future<void> atualizarDados() async {
    _atualizando.value = true;
    //busca os endereços cadastrados
    final response = await service.getEnderecos();
    _listagem.clear();
    _listagem.addAll(response);
    _atualizando.value = false;
  }

  final _listagem = <EnderecoModel>[].obs;
  List<EnderecoModel> get listagem => _listagem.toList();

  final _atualizando = false.obs;
  bool get atualizando => _atualizando.value;

  Future<bool> insertEndereco(EnderecoModel m) async {
    final response = await service.insertEndereco(m);
    await atualizarDados();
    return response != null;
  }

  Future<bool> updateEndereco(EnderecoModel m) async {
    final response = await service.updateEndereco(m);
    await atualizarDados();
    return response != null;
  }

  Future<bool> deleteEndereco(EnderecoModel m) async {
    final response = await service.deleteEndereco(m.id);
    await atualizarDados();
    return response;
  }
}
