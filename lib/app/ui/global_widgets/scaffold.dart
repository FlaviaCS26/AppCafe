import 'package:badges/badges.dart';
import 'package:cafe_gourmet/app/controllers/bottom_controller.dart';
import 'package:cafe_gourmet/app/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class WScaffold extends StatefulWidget {
  final Widget child;
  final bool bottomsNavigationBar;
  final bool isImageBackground;
  final Color colorBackground;

  const WScaffold({
    super.key,
    required this.child,
    this.bottomsNavigationBar = false,
    this.colorBackground = ThemeBase.color,
    this.isImageBackground = false,
  });

  @override
  State<WScaffold> createState() => _WScaffoldState();
}

class _WScaffoldState extends State<WScaffold> {
  BottomController? bottomController;

  @override
  void initState() {
    if(widget.bottomsNavigationBar) bottomController = Get.put(BottomController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: widget.colorBackground,
      body: body(),
      bottomNavigationBar: widget.bottomsNavigationBar ? bottomNavigator() : null,
    );
  }

  Widget body() {
    if (!widget.isImageBackground) return SafeArea(child: widget.child);
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: ThemeBase.color.withOpacity(.5),
        child: SafeArea(
          child: widget.child,
        ),
      ),
    );
  }

  Widget bottomNavigator() {
    return Obx(() => Container(
          color: Colors.white,
          height: 60.0,
          padding: const EdgeInsets.symmetric(vertical: 7.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: bottomController!.lista.map(buttonNav).toList(),
          ),
        ));
  }

  Widget buttonNav(BottomItemController m) {
    final current = Get.currentRoute;
    Color color = Colors.grey;
    if (current == m.url) color = ThemeBase.colorMaterial[700]!;
    return InkWell(
      onTap: () {
        if (current != m.url) Get.toNamed(m.url);
      },
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Badge(
          badgeContent: Text(
            m.notify.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11.0,
            ),
          ),
          badgeColor: ThemeBase.color,
          padding: const EdgeInsets.all(4),
          showBadge: m.notify > 0,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: FaIcon(
              m.icone,
              size: 20.0,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
