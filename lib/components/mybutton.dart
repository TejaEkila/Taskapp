// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:someapp/constant/constant.dart';

class Mybutton extends StatelessWidget {
  final ontap;
  final String text;

  const Mybutton({super.key,required this.ontap,required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(13),
        margin: EdgeInsets.symmetric(horizontal: 130),
        decoration: BoxDecoration(
          color:headcolor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
