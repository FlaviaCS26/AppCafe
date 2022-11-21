import 'package:cafe_gourmet/app/ui/utils/alerts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInController extends GetxController {
  final _atualizandoEmail = false.obs;
  bool get atualizandoEmail => _atualizandoEmail.value;
  final _atualizandoGoogle = false.obs;
  bool get atualizandoGoogle => _atualizandoGoogle.value;

  final _email = ''.obs;
  String get email => _email.value;
  setEmail(String v) => _email.value = v;

  final _senha = ''.obs;
  String get senha => _senha.value;
  setSenha(String v) => _senha.value = v;

  Future<void> loginEmail() async {
    try {
      _atualizandoEmail.value = true;
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );
      _atualizandoEmail.value = false;
      if (credential.user != null) await Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Alerts().errorSnackbar(
          'Nenhum usuário encontrado para esse e-mail.',
        );
      } else if (e.code == 'wrong-password') {
        Alerts().errorSnackbar(
          'Senha incorreta fornecida para esse usuário.',
        );
      } else if (e.code == 'No user found for that email') {
        Alerts().errorSnackbar(
          'Nenhum usuário encontrado para esse e-mail.',
        );
      }
    }
  }

  Future<void> loginGoogle() async {
    try {
      _atualizandoGoogle.value = true;
      final googleUser = await (GoogleSignIn().signIn());
      final googleAuth = await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      final user = FirebaseAuth.instance.currentUser;
      _atualizandoGoogle.value = false;
      if (user != null) await Get.offAllNamed('/home');
    } catch (e) {
      print(e);
      _atualizandoGoogle.value = false;
    }
  }

  Future<void> logoff() async {
    if (await Alerts().questionSnackbar('Deseja sair da sua conta?')) {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed('/sign_in');
    }
  }
}
