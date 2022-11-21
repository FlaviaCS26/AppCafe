import 'package:cafe_gourmet/app/ui/pages/cart/cart_screen.dart';
import 'package:cafe_gourmet/app/ui/pages/home/home_screen.dart';
import 'package:cafe_gourmet/app/ui/pages/requests/requests_screen.dart';
import 'package:cafe_gourmet/app/ui/pages/signIn/sign_in_loading_screen.dart';
import 'package:cafe_gourmet/app/ui/pages/signIn/sign_in_screen.dart';
import 'package:cafe_gourmet/app/ui/pages/user/user_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Routes {
  //rotas separadas com o seu widget
  static final _signInLoading = GetPage(
    name: '/',
    page: () => const SignInLoading(),
  );
  static final _signIn = GetPage(
    name: '/sign_in',
    page: () => const SignInScreen(),
  );
  static final _signUp = GetPage(
    name: '/sign_up',
    page: () => Container(),
  );
  static final _home = GetPage(
    name: '/home',
    page: () => const HomeScreen(),
    transition: Transition.noTransition,
  );
  static final _pedidos = GetPage(
    name: '/pedidos',
    page: () => RequestsScreen(),
    transition: Transition.noTransition,
  );
  static final _carrinho = GetPage(
    name: '/carrinho',
    page: () => CartScreen(),
    transition: Transition.noTransition,
  );
  static final _perfil = GetPage(
    name: '/perfil',
    page: () => const UserScreen(),
    transition: Transition.noTransition,
  );

  ///Rotas utilizadas no app
  static List<GetPage> pages() {
    return [
      _signInLoading,
      _signIn,
      _signUp,
      _home,
      _pedidos,
      _carrinho,
      _perfil,
    ];
  }
}
