import 'package:firebase_auth/firebase_auth.dart';

class UsuarioModel {
  String uid = '';
  String name = '';
  String email = '';
  String imageUrl = '';

  String get firstName {
    if (name.contains(' ')) return name.split(' ').first;
    return name;
  }

  UsuarioModel.fromUser(User user) {
    uid = user.uid;
    name = user.displayName ?? '';
    email = user.email ?? '';
    imageUrl = user.photoURL ?? '';
  }
}
