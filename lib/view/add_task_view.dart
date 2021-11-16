// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmanager/controller/task_controller.dart';
import 'package:taskmanager/model/task_model.dart';
import 'package:taskmanager/util/appUtil.dart';

class AddTaskView extends StatelessWidget {
  final TaskController _taskController = Get.find();
  final taskTitleCtrl = TextEditingController();
  final subtaskTitleCtrl = TextEditingController();
  final subtaskDetailCtrl = TextEditingController();
  final startDateCtrl = TextEditingController();
  final endDateCtrl = TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  AddTaskView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Add Tasks',
                  style: GoogleFonts.raleway(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              //Fields
              Column(
                children: [
                  //Task Title
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 6,
                      shadowColor: Colors.grey[300],
                      borderRadius: BorderRadius.circular(6),
                      child: TextFormField(
                        controller: taskTitleCtrl,
                        decoration: InputDecoration(
                            hintText: 'Task Group',
                            isDense: true,
                            hintStyle: GoogleFonts.raleway(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    ),
                  ),
                  //Subtask Title
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 6,
                      shadowColor: Colors.grey[300],
                      borderRadius: BorderRadius.circular(6),
                      child: TextFormField(
                        controller: subtaskTitleCtrl,
                        decoration: InputDecoration(
                            hintText: 'Task Title',
                            isDense: true,
                            hintStyle: GoogleFonts.raleway(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    ),
                  ),
                  //Subtask Desc
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 6,
                      shadowColor: Colors.grey[300],
                      borderRadius: BorderRadius.circular(6),
                      child: TextFormField(
                        controller: subtaskDetailCtrl,
                        textInputAction: TextInputAction.done,
                        minLines: 3,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Describe your task',
                          isDense: true,
                          hintStyle: GoogleFonts.raleway(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                  ),
                  //Start Date
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            elevation: 6,
                            shadowColor: Colors.grey[300],
                            borderRadius: BorderRadius.circular(6),
                            child: TextFormField(
                              readOnly: true,
                              onTap: () {
                                DatePicker.showDateTimePicker(context,
                                    onChanged: (val) {
                                  startDate = val;
                                  startDateCtrl.text =
                                      AppUtil.formatter.format(val);
                                });
                              },
                              controller: startDateCtrl,
                              decoration: InputDecoration(
                                  hintText: 'Start',
                                  isDense: true,
                                  hintStyle: GoogleFonts.raleway(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                            ),
                          ),
                        ),
                      ),
                      //End Date
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            elevation: 6,
                            shadowColor: Colors.grey[300],
                            borderRadius: BorderRadius.circular(6),
                            child: TextFormField(
                              readOnly: true,
                              controller: endDateCtrl,
                              onTap: () {
                                DatePicker.showDateTimePicker(context,
                                    onChanged: (val) {
                                  endDate = val;
                                  endDateCtrl.text =
                                      AppUtil.formatter.format(val);
                                });
                              },
                              decoration: InputDecoration(
                                  hintText: 'End',
                                  isDense: true,
                                  hintStyle: GoogleFonts.raleway(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              //Submit Btn
              Align(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  onPressed: () {
                    if (startDateCtrl.text.isNotEmpty &&
                        endDateCtrl.text.isEmpty) {
                      endDate = startDate;
                    }
                    _taskController.tasks.add(
                      TaskModel(
                        taskTitle: taskTitleCtrl.text,
                        subtaskList: [
                          SubtaskList(
                              subtaskTitle: subtaskTitleCtrl.text,
                              subtaskDetail: subtaskDetailCtrl.text,
                              subtaskStart: startDate,
                              subtaskEnd: endDate),
                        ],
                      ),
                    );
                    Get.back();
                  },
                  child: Text(
                    'Add',
                    style: GoogleFonts.raleway(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
