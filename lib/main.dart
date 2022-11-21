import 'package:cafe_gourmet/app/routes/routes.dart';
import 'package:cafe_gourmet/app/ui/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

///Caso já existe login efetuado, pula para HOME ou vai para LOGIN
String get initialRoute {
  if (FirebaseAuth.instance.currentUser != null) return '/home';
  return '/sign_in';
}

main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );
  //Faz splash esperando
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  //Realiza conexão com banco de dados
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    ///Remove splash
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('pt', 'BR'),
      title: 'Café Gourmet',
      theme: ThemeBase.theme(),
      getPages: Routes.pages(),
      initialRoute: initialRoute,
    );
  }
}
