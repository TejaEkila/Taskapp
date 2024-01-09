// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:someapp/Pages/adduser.dart';
import 'package:someapp/Pages/tail.dart';

import 'package:someapp/constant/constant.dart';
import 'package:someapp/database/database.dart';
import 'package:someapp/model/model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController tasknameController = TextEditingController();
  TextEditingController setdateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late DB db;

  List<DataModel> datas = [];
  bool fetching = true;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    db = DB();
    getData2();
    initControllers();
  }

  void getData2() async {
    datas = await db.getData();
    setState(() {
      fetching = false;
    });
  }

  void initControllers() {
    if (currentIndex < datas.length) {
      tasknameController.text = datas[currentIndex].taskname;
      setdateController.text = datas[currentIndex].setdate;
      descriptionController.text = datas[currentIndex].description;
    }
  }

  void _reset() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => const MyHomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () async {
            _reset();
            await FirebaseFirestore.instance.collection("newCollection").doc('newCollection').set({
              "Data":"working"
            }).then((value) => print('sucess'));
          },
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Go Task",
              style: headingstyle,
            ),
          ),
        ),
        elevation: 0,
        toolbarHeight: 72,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: background,
          ),
        ),
        //leading: Image.asset("assets/images/note.png",),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddUsers()),
              );
            },
            icon: Image.asset("assets/images/add.png"),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(gradient: fillcolor),
        child: datas.isEmpty
            ? Center(
                child: Padding(
                padding: const EdgeInsets.only(bottom: 450),
                child: Text(
                  'No task found',
                  style: textStyle,
                ),
              ))
            : ListView.builder(
                itemCount: datas.length,
                itemBuilder: ((context, index) => DataCard(
                      data: datas[index],
                      edit: edit,
                      index: index,
                      delete: delete,
                    )),
              ),
      ),
    );
  }

  void edit(int index) {
    setState(() {
      currentIndex = index;
      initControllers();
    });
  }

  void delete(int index) async {
    db.deleteData(datas[index].id!);
    setState(() {
      datas.removeAt(index);
    });
  }
}
