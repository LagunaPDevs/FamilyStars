import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Common item for formulary fields

class CommonTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final Function onChanged;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final TextStyle? labelStyle;
  final FocusNode? focusNode;
  final Function(String) onFieldSubmitted;
  final TextInputType? textInputType;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final Color? enableBorderColor;
  final bool isNumber;
  final TextStyle? inputTextStyle;
  final int? maxLine;
  final List<TextInputFormatter>? inputFormatter;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FormFieldValidator<String>? validation;

  const CommonTextFormField(
      {Key? key,
      required this.controller,
      required this.onChanged,
      this.errorText,
      this.hintText,
      this.labelText,
      this.labelStyle,
      this.focusNode,
      required this.onFieldSubmitted,
      this.textInputType,
      this.obscureText,
      this.textInputAction,
      this.enableBorderColor,
      this.inputTextStyle,
      this.isNumber = false,
      this.maxLine,
      this.inputFormatter,
      this.suffixIcon,
      this.validation,
      this.prefixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: (value) {
        onChanged(value);
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validation,
      focusNode: focusNode,
      maxLines: maxLine ?? 1,
      minLines: 1,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: textInputType,
      obscureText: obscureText ?? false,
      textInputAction: textInputAction,
      cursorColor: ColorConstants.blueColor,
      style: TextStyle(
        color: Theme.of(context).brightness == Brightness.light
            ? ColorConstants.greyColor
            : ColorConstants.greyColor,
        fontSize: 12,
      ),
      inputFormatters: inputFormatter,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        errorText: errorText,
        hintText: hintText,
        hintStyle: TextStyle(color: ColorConstants.greyColor, fontSize: 14),
        labelText: labelText,
        labelStyle: labelStyle,
        isDense: true,
        filled: true,
        fillColor: ColorConstants.whiteColor,
        contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 5.0, 20.0),
        errorStyle: TextStyle(
          color: ColorConstants.blueColor,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
        ),
      ),
    );
  }
}
