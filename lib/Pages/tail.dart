// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:someapp/pages/edit/editpage.dart';
import 'package:someapp/constant/constant.dart';

import 'package:someapp/model/model.dart';

class DataCard extends StatefulWidget {
  const DataCard({Key? key, required this.data, required this.edit, required this.index, required this.delete}) : super(key: key);

  final DataModel data;
  final Function edit;
  final int index;
  final Function delete;

  @override
  State<DataCard> createState() => _DataCardState();
}

class _DataCardState extends State<DataCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              print(widget.data.id!);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Editpage(data: widget.data, edit: widget.edit, delete: widget.delete, index: widget.index,),
                ),
              );
            },
            child: Center(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: Container(
                      height: 110,
                      width: 408,
                      decoration: BoxDecoration(border: Border.all(color: background), color: Colors.white, borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(11),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              height: 100,
                              width: 80,
                              decoration: BoxDecoration(
                                color: background,
                              ),
                              child: Image.asset(
                                "assets/images/logo.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      children: [
                                        const Gap(10),
                                        Text(
                                          "TASK NAME ${widget.data.id}",
                                          style: taskstyle,
                                        ),
                                      ],
                                    )),
                                const Gap(7),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      children: [
                                        const Gap(10),
                                        Text(
                                          "Priority level :",
                                          style: textStyle,
                                        ),
                                      ],
                                    )),
                                const Gap(7),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      children: [
                                        const Gap(10),
                                        Text(
                                          "Date : ${widget.data.setdate}",
                                          style: textStyle,
                                        ),
                                      ],
                                    )),
                                const Gap(10),
                              ],
                            )),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFA6CBF8), width: 1.0),
                              borderRadius: BorderRadius.circular(5),
                              color: isChecked ? headcolor : background,
                            ),
                            child: isChecked
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 30,
                                  )
                                : null,
                          ),
                        ),
                        const Gap(30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
