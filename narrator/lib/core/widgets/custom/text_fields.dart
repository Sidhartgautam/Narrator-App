import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../resources/colors.dart';

class PrimaryTextField extends StatelessWidget {
  final Function(String)? onValueChange;
  final String hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final Color? border;
  final bool? showError;
  final bool? autofocus;
  final Function()? onTap;
  final Function(String)? onSubmitted;
  final TextCapitalization textCapitalization;
  final Color? fillColor;
  final bool showLable;
  final FocusNode? focusNode;
  final double borderRadius;
  final int? maxLine;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;

  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final bool? readOnly;

  const PrimaryTextField({
    Key? key,
    required this.hint,
    this.onValueChange,
    this.controller,
    this.validator,
    required this.textInputAction,
    required this.textInputType,
    this.border,
    this.showError = true,
    this.textCapitalization = TextCapitalization.sentences,
    this.onTap,
    this.onSubmitted,
    this.autofocus = false,
    this.showLable = false,
    this.fillColor,
    this.focusNode,
    this.borderRadius = 10,
    this.maxLine,
    this.inputFormatters,
    this.focusedBorder,
    this.enabledBorder,
    this.minLines, this.readOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      readOnly: readOnly ?? false,
      inputFormatters: inputFormatters,
      maxLines: maxLine,
      minLines: minLines,
      focusNode: focusNode,
      autofocus: autofocus!,
      textCapitalization: textCapitalization,
      onFieldSubmitted: onSubmitted,
      onTap: (onTap != null) ? onTap! : null,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      // maxLines: 1,
      validator: (validator != null) ? validator : null,
      controller: controller,
      onChanged: (text) {
        if (onValueChange != null) {
          onValueChange!(text);
        }
      },
      decoration: InputDecoration(
        label: showLable
            ? Text(
                hint,
                style: const TextStyle(color: primaryColor, fontSize: 16),
              )
            : null,
        fillColor: fillColor ?? Colors.transparent,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              borderSide: BorderSide(width: 1, color: (border == null) ? primaryColor : border!),
            ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: BorderSide(width: 1, color: (border == null) ? primaryColor : border!),
        ),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              borderSide: BorderSide(width: 1, color: (border == null) ? primaryColor : border!),
            ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: const BorderSide(width: 1, color: redColorDark),
        ),
        errorStyle: (showError!) ? const TextStyle(fontSize: 12) : const TextStyle(fontSize: 0),
        hintText: hint,
        hintStyle: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),
      ),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
    );
  }
}
