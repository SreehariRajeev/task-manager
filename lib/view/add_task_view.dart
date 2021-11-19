import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:taskmanager/controller/task_controller.dart';
import 'package:taskmanager/util/appUtil.dart';
import 'styles/text_field_decoration.dart';
import 'widgets/custom_widgets.dart';

class AddTask extends StatelessWidget with AppUtil, CustomDecoration {
  final TaskController taskController = Get.find();

  ValueNotifier<TextEditingController> taskTitleCtrl =
      ValueNotifier(TextEditingController());
  final taskDetailCtrl = TextEditingController();
  final startDateCtrl = TextEditingController();
  final endDateCtrl = TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final taskGroup = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: customAppBar,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Header
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CategoryTitleWidget(
                  title: taskGroup.toString(),
                ),
              ),
              //Fields
              Column(
                children: [
                  //Task Title
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: taskTitleCtrl.value,
                      decoration:
                          textFieldDecoration(hintTextStr: 'Task Title'),
                    ),
                  ),
                  //task Desc
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: taskDetailCtrl,
                      minLines: 3,
                      maxLines: 5,
                      decoration: textFieldDecoration(
                          hintTextStr: 'Describe your task'),
                    ),
                  ),
                  //Start Date
                  Row(
                    children: [
                      Flexible(flex: 1, child: TaskStartDateField()),
                      //End Date
                      Flexible(flex: 1, child: TaskEndDateField()),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              //Submit Btn
              Align(
                child: AddTaskSubmitBtn(
                  taskGroup: taskGroup.toString(),
                  taskTitleCtrl: taskTitleCtrl.value,
                  taskDetailCtrl: taskDetailCtrl,
                  startDate: taskController.startDate.value,
                  endDate: taskController.endDate.value,
                ),
              ),
            ],
          ),
        ));
  }
}

//End DT Field
class TaskEndDateField extends StatelessWidget with AppUtil, CustomDecoration {
  final TextEditingController dateCtrl = TextEditingController();
  final TaskController taskController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        readOnly: true,
        controller: dateCtrl,
        onTap: () {
          DatePicker.showDateTimePicker(context, onChanged: (val) {
            taskController.endDate = val.obs;
            dateCtrl.text = formatter.format(val);
          });
        },
        decoration: textFieldDecoration(hintTextStr: 'End'),
      ),
    );
  }
}

//Start DT Field
class TaskStartDateField extends StatelessWidget
    with AppUtil, CustomDecoration {
  final TextEditingController dateCtrl = TextEditingController();
  final TaskController taskController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        readOnly: true,
        controller: dateCtrl,
        onTap: () {
          DatePicker.showDateTimePicker(context, onChanged: (val) {
            taskController.startDate = val.obs;
            dateCtrl.text = formatter.format(val);
          });
        },
        decoration: textFieldDecoration(hintTextStr: 'Start'),
      ),
    );
  }
}

//Add Task Submit Button
class AddTaskSubmitBtn extends StatelessWidget {
  AddTaskSubmitBtn(
      {Key? key,
      required this.taskTitleCtrl,
      required this.taskDetailCtrl,
      required this.startDate,
      required this.endDate,
      required this.taskGroup})
      : super(key: key);
  final TaskController taskController = Get.find();
  final TextEditingController taskTitleCtrl;
  final TextEditingController taskDetailCtrl;
  final DateTime startDate;
  final DateTime endDate;
  final Object? taskGroup;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black),
        ),
        onPressed: () {
          taskController.addTask(
            groupName: taskGroup.toString(),
            taskTitle: taskTitleCtrl.text,
            taskDesc: taskDetailCtrl.text,
            startDate: startDate,
            endDate: endDate,
          );
          Get.back();
        },
        child: Text(
          'Add',
          style: GoogleFonts.raleway(fontWeight: FontWeight.w600),
        ));
  }
}
