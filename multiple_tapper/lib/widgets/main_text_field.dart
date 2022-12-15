import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multiple_tapper/utils/utils.dart';

class MainTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final Function(String?)? onSaved;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final bool? enabled;
  final bool? isPassword;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final int? maxLines;
  final int? minLines;
  final FocusNode? focusNode;
  final AutovalidateMode? autovalidateMode;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? inputFormatters;

  const MainTextField({
    Key? key,
    this.onSaved,
    this.onChanged,
    this.hintText = '',
    this.labelText = '',
    this.autovalidateMode,
    this.validator,
    this.inputType,
    this.isPassword = false,
    this.inputAction,
    this.enabled = true,
    this.suffixIcon,
    this.controller,
    this.maxLines = 5,
    this.minLines = 1,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      textInputAction: inputAction,
      obscureText: isPassword == true ? true : false,
      autovalidateMode: autovalidateMode,
      textAlign: textAlign!,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle:
            TextStyle(color: Colors.grey.shade300, fontSize: 14, height: 1),
        border: const OutlineInputBorder(
          borderSide: BorderSide(),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        suffixIcon: suffixIcon,
      ),
      controller: controller,
      onChanged: onChanged,
      onSaved: onSaved,
      validator: validator,
      enabled: enabled,
      maxLines: maxLines,
      minLines: minLines,
      focusNode: focusNode,
      inputFormatters: inputFormatters ?? [allAllow],
    );
  }
}
