import 'package:flutter/material.dart';

class MainInputDecoration extends InputDecoration {
  static final defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none);

  MainInputDecoration()
      : super(
          errorStyle: TextStyle(color: Colors.white, fontSize: 16),
          border: defaultBorder,
          disabledBorder: defaultBorder,
          enabledBorder: defaultBorder,
          errorBorder: defaultBorder.copyWith(
              borderSide: BorderSide(color: Colors.red, width: 2)),
          focusedBorder: defaultBorder,
          focusedErrorBorder: defaultBorder,
          filled: true,
          contentPadding: EdgeInsets.only(top: 20),
          focusColor: Colors.white,
          fillColor: Colors.white,
        );
}
