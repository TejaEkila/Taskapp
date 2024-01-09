// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:someapp/Pages/adduser.dart';
import 'package:someapp/components/mytextfield.dart';
import 'package:someapp/constant/constant.dart';
import 'package:someapp/database/database.dart';
import 'package:someapp/model/model.dart';

class Editpage extends StatefulWidget {
  final DataModel data;
  final Function edit;
  final Function delete;
  final int index;

  const Editpage({Key? key, required this.data, required this.edit, required this.delete, required this.index}) : super(key: key);

  @override
  State<Editpage> createState() => _EditpageState();
}

class _EditpageState extends State<Editpage> {
  TextEditingController tasknameController = TextEditingController();
  TextEditingController setdateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  late DB db;
  List<DataModel> datas = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    db = DB();
    getData2();

    // Initialize controllers with the passed data
    tasknameController.text = widget.data.taskname;
    setdateController.text = widget.data.setdate;
    descriptionController.text = widget.data.description;
  }

  Future<void> getData2() async {
    datas = await db.getData();
    setState(() {});
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

  void delete(int index) async {
    db.deleteData(datas[index].id!);
    setState(() {
      datas.removeAt(index);
    });
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
        toolbarHeight: 72,
        elevation: 0,
        centerTitle: false,
        title: Text(
          "Edit Task",
          style: headingstyle,
        ),
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
              print('working');
              try {
                // Update the existing data in the list
                widget.data.taskname = tasknameController.text;
                widget.data.setdate = setdateController.text;
                widget.data.description = descriptionController.text;
                widget.data.isImportant = isImportant;
                widget.data.isNone = isNone;

                // Update the data in the database
                await db.updateData(widget.data, widget.data.id!);

                // Refresh data after the update
                await getData2();

                Navigator.pop(context);
              } catch (e) {
                print("Error updating data: $e");
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
           
            SizedBox(
              height: 70,
              width: 400,
              //color: Colors.amber,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Text(
                  "Delete Task?",
                  style: taskstyle,
                ),
                const Gap(170),
                GestureDetector(
                  onTap: () {
                    delete(widget.index); // Pass widget.index to the delete function
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(color: headcolor, borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        "Delete",
                        style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            const Gap(10),
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
            const Gap(5),
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
            const Gap(5),
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
            const Gap(5),
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
            const Gap(27),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomRectangularRadioButton(
                  isSelected: isSelected1,
                  onTap: () {
                    setState(() {
                      print('importent');
                      isSelected1 = true;
                    });
                  },
                ),
                Text("importect",style: prioritylevelstyle),
                const Gap(32),
                CustomRectangularRadioButton(
                  isSelected: !isSelected1,
                  onTap: () {
                    print('none');
                    setState(() {
                      isSelected1 = false;
                    });
                  },
                ),
                Text("None",style: prioritylevelstyle,),
                const Gap(130)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
