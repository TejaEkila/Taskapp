// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:someapp/Pages/home/gotask.dart';
import 'package:someapp/components/mybutton.dart';
import 'package:someapp/components/mytextfield.dart';
import 'package:someapp/constant/constant.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: fillcolor),
        child: Column(children: [
          const Gap(80),
          Center(
            child: Text(
              "Welcome",
              style: headingstyle,
            ),
          ),
          Center(
            child: Text(
              "Login to continue",
              style: textStyle,
            ),
          ),
          const Gap(50),
          Row(
            children: [
              const Gap(20),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Email / Phone",
                    style: textStyle,
                  )),
            ],
          ),
          Mytextfield(
            Controller: emailController,
            date: null,
          ),
          const Gap(10),
          Row(
            children: [
              const Gap(20),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Password",
                    style: textStyle,
                  )),
            ],
          ),
          Mytextfield(
            Controller: passwordController,
            date: null,
          ),
          const Gap(15),
          Mybutton(
            ontap: () {
              print("login");
              if (emailController.text == "username" && passwordController.text == "abcdef") {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomePage()));
                
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Invalid Credentials')),
                );
              }
    
            },
            text: 'Login',
          ),
          const Gap(20),
          RichText(
              text: TextSpan(children: [
            TextSpan(
              text: "Don't have an Account?",
              style: textStyle,
            ),
            TextSpan(text: " Sign up", style: subhaedings)
          ])),
        ]),
      ),
    );
  }
}
