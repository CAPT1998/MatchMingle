import 'package:flutter/material.dart';

Widget TextWidget({
  required String title,
  required double size,
  FontWeight? fontWeight,
  dynamic maxline,
  dynamic color,
  dynamic textAlign,
  TextOverflow? overflow,
}) {
  return Text(
    "$title",
    // maxLines: maxline ?? 1,
    textAlign: textAlign ?? TextAlign.start,
    // overflow: overflow,
    style: TextStyle(
      fontSize: size,
      fontWeight: fontWeight ?? FontWeight.w700,
      color: color ?? Colors.black,
    ),
  );
}
