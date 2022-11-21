import 'package:cafe_gourmet/app/ui/global_widgets/scaffold.dart';
import 'package:cafe_gourmet/app/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class WScaffoldDetail extends StatefulWidget {
  final bool onPop;
  final Widget child;
  final String title;
  final Widget? rWidget;
  final bool initColorStatus;
  final bool disposeColorStatus;

  const WScaffoldDetail({
    super.key,
    this.onPop = true,
    required this.child,
    required this.title,
    this.initColorStatus = true,
    this.disposeColorStatus = true,
    this.rWidget,
  });

  @override
  State<WScaffoldDetail> createState() => _WScaffoldDetailState();
}

class _WScaffoldDetailState extends State<WScaffoldDetail> {
  @override
  void initState() {
    if (widget.initColorStatus) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.disposeColorStatus) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      );
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(widget.onPop),
      child: WScaffold(
        colorBackground: ThemeBase.color,
        isImageBackground: false,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15.0,
            right: 15.0,
            top: 20.0,
          ),
          child: body(),
        ),
      ),
    );
  }

  Widget body() {
    return Column(
      children: [
        top(),
        Expanded(child: widget.child),
      ],
    );
  }

  Widget top() {
    return SizedBox(
      height: 30.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.onPop)
            GestureDetector(
              onTap: Get.back,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 8.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.2),
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child: const FaIcon(
                  FontAwesomeIcons.arrowLeftLong,
                  color: Colors.white54,
                  size: 16.0,
                ),
              ),
            ),
          Expanded(
            child: Center(
              child: Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          if (widget.rWidget != null) widget.rWidget!,
        ],
      ),
    );
  }
}
