import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget textfieldProduct({
  TextEditingController? controller,
  required BuildContext context,
  required String name,
  TextInputType? inputtype,
  double? width,
  bool? isread,
  int? maxline,
  String? value,
  List<TextInputFormatter>? inputFormatters,
  dynamic prefixIcon,
  dynamic suffixIcon,
  String? fieldtype,
  String? labelText,
  dynamic maxlength,
  Function(String)? onChanged,
  bool? obscureText,
}) {
  return Container(
    width: width,
    child: TextFormField(
      obscureText: obscureText ?? false,
      keyboardType: inputtype ?? TextInputType.text,
      initialValue: value,
      readOnly: isread ?? false,
      maxLines: maxline ?? 1,
      maxLength: maxlength,
      onChanged: onChanged ?? (value) {},
      style: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      inputFormatters: inputFormatters ??
          <TextInputFormatter>[
            FilteringTextInputFormatter.singleLineFormatter,
          ],
      validator: (value) {
        if (value!.isEmpty) {
          return "Required this field";
        } else {
          return null;
        }
      },
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: name,
        labelText: labelText ?? "",
        alignLabelWithHint: true,
        fillColor: Colors.grey[50],
        hintStyle: Theme.of(context).textTheme.bodyText1!.merge(
              TextStyle(color: Colors.grey),
            ),
        labelStyle: Theme.of(context).textTheme.bodyText1!.merge(
              TextStyle(color: Colors.black,fontSize: 18),
            ),
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.black),
        ),
      ),
    ),
  );
}
