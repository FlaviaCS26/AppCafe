import 'package:cafe_gourmet/app/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WDTextField extends StatefulWidget {
  final EdgeInsetsGeometry margin;
  final Function(String)? onChanged;
  final String? title;
  final String? hint;
  final String? initialText;
  final TextAlign textAlign;
  final bool isPassword;
  final bool isEnabled;
  final int minLines;
  final int maxLines;
  final double borderRadius;
  final Color colorText;
  final Color? colorHint;
  final Color colorDecoration;
  final Color? colorCursor;
  final Color colorBackground;
  final Widget? rightWd;
  final bool initialFocused;
  final TextInputType? textInputType;
  final Function? onEnter;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? filled;

  const WDTextField({
    Key? key,
    this.margin = EdgeInsets.zero,
    required this.onChanged,
    this.title,
    this.hint,
    this.initialText,
    this.textAlign = TextAlign.left,
    this.isPassword = false,
    this.isEnabled = true,
    this.minLines = 1,
    this.maxLines = 1,
    this.borderRadius = 40.0,
    this.colorText = ThemeBase.color,
    this.colorHint,
    this.colorCursor,
    this.colorDecoration = ThemeBase.color,
    this.colorBackground = Colors.transparent,
    this.rightWd,
    this.textInputType,
    this.initialFocused = false,
    this.onEnter,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.controller,
    this.focusNode,
    this.filled,
  }) : super(key: key);

  @override
  WDTextFieldState createState() => WDTextFieldState();
}

class WDTextFieldState extends State<WDTextField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: TextFormField(
        focusNode: widget.focusNode,
        controller: widget.controller,
        onChanged: widget.onChanged,
        initialValue: widget.initialText,
        textAlign: widget.textAlign,
        obscureText: widget.isPassword ? isObscure : false,
        decoration: decoration,
        readOnly: !widget.isEnabled,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        cursorColor: widget.colorCursor ?? widget.colorDecoration,
        autofocus: widget.initialFocused,
        keyboardType: widget.textInputType,
        inputFormatters: widget.inputFormatters,
        textCapitalization: widget.textCapitalization,
        onFieldSubmitted: (v) {
          if (widget.onEnter != null) widget.onEnter!();
        },
        style: TextStyle(color: widget.colorText),
      ),
    );
  }

  InputDecoration get decoration {
    return InputDecoration(
      contentPadding: widget.filled != null && widget.filled!
          ? const EdgeInsets.symmetric(
              vertical: 9.0,
              horizontal: 12.0,
            )
          : null,
      isDense: true,
      filled: true,
      hintText: widget.hint,
      hintStyle: TextStyle(
        color: widget.colorHint ?? widget.colorText,
      ),
      labelText: widget.title,
      labelStyle: TextStyle(
        color: widget.colorDecoration,
      ),
      fillColor: widget.colorBackground,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: widget.colorDecoration,
        ),
        borderRadius: BorderRadius.circular(
          widget.borderRadius,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: widget.colorDecoration.withOpacity(0.6),
        ),
        borderRadius: BorderRadius.circular(
          widget.borderRadius,
        ),
      ),
      suffixIcon: widget.rightWd ?? iconPassword,
    );
  }

  Widget? get iconPassword {
    if (widget.isPassword) {
      return IconButton(
        onPressed: () => setState(() => isObscure = !isObscure),
        icon: FaIcon(
          isObscure ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
        ),
        iconSize: 20.0,
        color: ThemeBase.color,
      );
    }
    return null;
  }
}
