// adduser.dart

// ignore_for_file: avoid_print, use_build_context_synchronously, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:someapp/components/mytextfield.dart';
import 'package:someapp/constant/constant.dart';
import 'package:someapp/database/database.dart';
import 'package:someapp/model/model.dart';

class AddUsers extends StatefulWidget {
  const AddUsers({super.key});

  @override
  State<AddUsers> createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {
  TextEditingController tasknameController = TextEditingController();
  TextEditingController setdateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  late DB db;

  List<DataModel> datas = [];

  @override
  void initState() {
    super.initState();
    db = DB();
    getData2();
  }

  void getData2() async {
    datas = await db.getData();
    setState(() {});
  }

  int count = 0;

  void incrementCount() {
    setState(() {
      count++;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        setdateController.text = picked.toString().split(' ')[0];
      });
    }
  }

  bool isImportant = false;
  bool isNone = false;

  void handleCheckboxSelection(bool isImportantCheckbox, bool isNoneCheckbox) {
    setState(() {
      isImportant = isImportantCheckbox;
      isNone = isNoneCheckbox;

      // Ensure only one checkbox is selected at a time
      if (isImportant && isNone) {
        isImportant = false;
      }
    });
  }

  bool isSelected1 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text(
          "Add Task",
          style: headingstyle,
        ),
        toolbarHeight: 72,
        flexibleSpace: Container(
          decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(20)),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: headcolor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              incrementCount();
              DataModel datalocal = DataModel(
                taskname: tasknameController.text,
                setdate: setdateController.text,
                description: descriptionController.text,
                isImportant: isImportant, // Pass correct values
                isNone: isNone, // Pass correct values
              );
              bool success = await db.insertDB(datalocal); // Wait for the insertion to complete

              if (success) {
                // Refresh the data after successful insertion
                getData2();

                setState(() {
                  datas.add(datalocal);
                });

                tasknameController.clear();
                setdateController.clear();
                descriptionController.clear();
                isSelected1 = false;
                Navigator.pop(context);
              } else {
                // Handle the case where insertion fails
                // You might want to show an error message to the user
                print('Error inserting data into the database');
              }
            },
            icon: Image.asset("assets/images/save.png"),
          )
        ],
      ),
      body: Container(
        width: 430,
        decoration: BoxDecoration(gradient: fillcolor),
        child: Column(
          children: [
            const Gap(20),
            Row(
              children: [
                const Gap(20),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Task Name",
                    style: textStyle,
                  ),
                ),
              ],
            ),
            Mytextfield(
              Controller: tasknameController,
              date: null,
            ),
            const Gap(15),
            Row(
              children: [
                const Gap(20),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Set Date",
                    style: textStyle,
                  ),
                ),
              ],
            ),
            Mytextfield(
              Controller: setdateController,
              date: IconButton(
                icon: Image.asset("assets/images/calendar.png"),
                onPressed: () => _selectDate(context),
              ),
            ),
            const Gap(15),
            Row(
              children: [
                const Gap(20),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Description",
                    style: textStyle,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                width: 400,
                height: 86,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: TextField(
                  maxLines: 2,
                  controller: descriptionController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(55, 135, 235, 1))),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(55, 135, 235, 1))),
                    fillColor: Color.fromRGBO(166, 203, 248, 1),
                    filled: true,
                  ),
                ),
              ),
            ),
            const Gap(15),
            Row(
              children: [
                const Gap(20),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Priority Level",
                    style: textStyle,
                  ),
                ),
              ],
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomRectangularRadioButton(
                 
                  isSelected: isSelected1,
                  onTap: () {
                    setState(() {
                      print('importent');
                      isSelected1 = true;
                      handleCheckboxSelection(false, true);
                    });
                  },
                ),
                Text("importect",style: prioritylevelstyle,),
                const Gap(32),
                CustomRectangularRadioButton(
                 
                  isSelected: !isSelected1,
                  onTap: () {
                    print('none');
                    setState(() {
                      isSelected1 = false;
                      handleCheckboxSelection(true, false);
                    });
                  },
                ),
                Text("None",style: prioritylevelstyle,),
                const Gap(130),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomRectangularRadioButton extends StatelessWidget {
  
  final bool isSelected;
  final VoidCallback onTap;

CustomRectangularRadioButton({
   
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFA6CBF8), width: 2.0),
                color: isSelected ? headcolor : background,
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      size: 30,
                      color: Colors.white,
                    )
                  : null),
        ],
      ),
    );
  }
}
