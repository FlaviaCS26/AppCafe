import 'package:cafe_gourmet/app/ui/utils/alerts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final _atualizando = false.obs;
  bool get atualizando => _atualizando.value;

  final _nome = ''.obs;
  String get nome => _nome.value;
  setNome(String v) => _nome.value = v;

  final _email = ''.obs;
  String get email => _email.value;
  setEmail(String v) => _email.value = v;

  final _senha = ''.obs;
  String get senha => _senha.value;
  setSenha(String v) => _senha.value = v;

  Future<bool> createLoginEmail() async {
    try {
      _atualizando.value = true;
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
      await credential.user!.updateDisplayName(nome);
      _atualizando.value = false;
      return true;
    } on FirebaseAuthException catch (e) {
      _atualizando.value = false;
      if (e.code == 'weak-password') {
        Alerts().errorSnackbar(
          'A senha fornecida é muito fraca.',
        );
      } else if (e.code == 'email-already-in-use') {
        Alerts().errorSnackbar(
          'A conta já existe para esse e-mail.',
        );
      }
      return false;
    } catch (e) {
      _atualizando.value = false;
      print(e);
      return false;
    }
  }
}
