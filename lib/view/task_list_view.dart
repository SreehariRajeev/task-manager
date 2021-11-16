import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmanager/controller/task_controller.dart';
import 'package:taskmanager/util/appUtil.dart';
import 'package:taskmanager/view/add_task_view.dart';

// ignore: use_key_in_widget_constructors
class TaskManagerView extends StatelessWidget {
  final taskController = Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black87,
        onPressed: () {
          Get.to(() => AddTaskView());
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Task Manager',
                style: GoogleFonts.raleway(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GetX<TaskController>(builder: (controller) {
                return controller.tasks.isNotEmpty
                    ? ListView.builder(
                        itemCount: controller.tasks.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ExpansionTile(
                              expandedAlignment: Alignment.centerLeft,
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                              title: Text(controller.tasks[index].taskTitle!),
                              children: <Widget>[
                                for (var i
                                    in controller.tasks[index].subtaskList!)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ExpansionTile(
                                      expandedAlignment: Alignment.centerLeft,
                                      expandedCrossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      title: Text(i.subtaskTitle!),
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(i.subtaskDetail!),
                                              Text(AppUtil.formatter
                                                  .format(i.subtaskStart!)),
                                              Text(AppUtil.formatter
                                                  .format(i.subtaskEnd!))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          );
                        })
                    : Center(
                        child: Text(
                        'No task to show, click + button to add task',
                        style: GoogleFonts.raleway(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ));
              }),
            )
          ],
        ),
      ),
    );
  }
}
