// ignore_for_file: prefer_const_constructors, camel_case_types, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class Mytextfield extends StatelessWidget {
  final Controller;

  final date;
  //final String hinttext;
  // final bool obscureText;

  const Mytextfield({
    super.key,
    required this.Controller,

    required this.date,
    // required this.obscureText, required Null Function(dynamic value) validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: 400,
        height: 50,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: TextField(
          controller: Controller,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(55, 135, 235, 1))),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(55, 135, 235, 1))),
            fillColor: Color.fromRGBO(166, 203, 248, 1),
            filled: true,
            suffixIcon: date,
          ),
        ),
      ),
    );
  }
}
