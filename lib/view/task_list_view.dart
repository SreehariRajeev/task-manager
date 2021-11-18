// ignore_for_file: use_key_in_widget_constructors, must_be_immutable
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmanager/controller/task_controller.dart';
import 'package:taskmanager/model/task_model.dart';
import 'package:taskmanager/util/appUtil.dart';

class TaskManager extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Task Manager',
          style: GoogleFonts.raleway(),
        ),
      ),
      body: TaskGroups(),
    );
  }
}

class TaskGroups extends HookWidget with AppUtil {
  final TaskController taskController = Get.find();
  final TextEditingController _searchCtrl = TextEditingController();
  ValueNotifier<List<TaskModel>> searchList = ValueNotifier([]);
  @override
  Widget build(BuildContext context) {
    final navigatorIndex = useState(0);

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],

      body: ValueListenableBuilder(
          valueListenable: _searchCtrl,
          builder: (context, value, child) {
            return Column(
              children: [
                //Group Name and Add Group Button
                GetX<TaskController>(builder: (controller) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Group Name
                        Text(
                          controller.taskGroups[navigatorIndex.value].group,
                          style: GoogleFonts.raleway(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        //Add Group Button and Navigate Arrows
                        Row(
                          children: [
                            //Add Group Button
                            IconButton(
                              onPressed: () {
                                showAddGroupDialog(context);
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),

                            //Previous Group Button
                            navigatorIndex.value > 0
                                ? IconButton(
                                    onPressed: () {
                                      navigatorIndex.value =
                                          navigatorIndex.value - 1;
                                      taskController.loadTasks(taskController
                                          .taskGroups[navigatorIndex.value]
                                          .group);
                                    },
                                    icon: const Icon(
                                      Icons.navigate_before,
                                      color: Colors.white,
                                    ),
                                  )
                                : Container(),

                            //Next Group Button
                            navigatorIndex.value + 1 !=
                                    controller.taskGroups.length
                                ? IconButton(
                                    onPressed: () {
                                      navigatorIndex.value =
                                          navigatorIndex.value + 1;
                                      taskController.loadTasks(taskController
                                          .taskGroups[navigatorIndex.value]
                                          .group);
                                    },
                                    icon: const Icon(
                                      Icons.navigate_next,
                                      color: Colors.white,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ],
                    ),
                  );
                }),

                //Search Field
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _searchCtrl,
                    textInputAction: TextInputAction.search,
                    onChanged: (_) {
                      searchList.value =
                          taskController.searchTasks(_searchCtrl.text);
                    },
                    style: GoogleFonts.raleway(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.5),
                      hintText: 'Search',
                      isDense: true,
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 20,
                      ),
                      hintStyle: GoogleFonts.raleway(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),

                //View Task and Searched Tasks widget
                searchList.value.isNotEmpty
                    ? Expanded(
                        child: SearchResult(
                          searchedList: searchList.value,
                        ),
                      )
                    : Expanded(
                        child: Task(
                        groupName: taskController
                            .taskGroups[navigatorIndex.value].group,
                      )),
              ],
            );
          }),

      //Add Tasks Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/add-task',
              arguments: taskController.taskGroups[navigatorIndex.value].group);
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add_task),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}

//Task Widget
class Task extends StatelessWidget with AppUtil {
  Task({required this.groupName});
  final TaskController taskController = Get.find();
  final ValueNotifier<bool> isCompleted = ValueNotifier<bool>(false);
  final String groupName;
  @override
  Widget build(BuildContext context) {
    return GetX<TaskController>(builder: (controller) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: controller.tasks.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Dismissible(
                key: UniqueKey(),
                onDismissed: (_) {
                  taskController.tasks.removeAt(index);
                  taskController.updateTask(groupName);
                },
                child: Card(
                  child: ExpansionTile(
                    title: ValueListenableBuilder(
                        valueListenable: isCompleted,
                        builder: (context, value, child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.green,
                                      shape: const CircleBorder(),
                                      value: taskController
                                          .tasks[index].isCompleted,
                                      onChanged: (val) {
                                        var changed =
                                            taskController.tasks[index];
                                        changed.isCompleted = val!;
                                        taskController.tasks[index] = changed;
                                      }),
                                  Text(
                                    controller.tasks[index].title,
                                    style: GoogleFonts.raleway(
                                      decoration: !taskController
                                              .tasks[index].isCompleted
                                          ? TextDecoration.none
                                          : TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                taskController.checkDate(
                                    taskController.tasks[index].start!),
                                style: GoogleFonts.raleway(),
                              ),
                            ],
                          );
                        }),
                    expandedAlignment: Alignment.centerLeft,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.tasks[index].detail ?? '',
                              style: GoogleFonts.raleway(),
                            ),
                            Text(
                              timeFormatter
                                  .format(controller.tasks[index].start!),
                              style: GoogleFonts.raleway(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            controller.tasks[index].end != null
                                ? Text(
                                    timeFormatter
                                        .format(controller.tasks[index].end!),
                                    style: GoogleFonts.raleway(
                                        decoration: TextDecoration.none),
                                  )
                                : Container(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    });
  }
}

//Search Result Widget
class SearchResult extends StatelessWidget with AppUtil {
  SearchResult({Key? key, required this.searchedList}) : super(key: key);
  final List<TaskModel> searchedList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: searchedList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Dismissible(
              key: UniqueKey(),
              onDismissed: (_) {
                searchedList.removeAt(index);
              },
              child: Card(
                child: ExpansionTile(
                  title: Text(
                    searchedList[index].title,
                    style: GoogleFonts.raleway(decoration: TextDecoration.none),
                  ),
                  expandedAlignment: Alignment.centerLeft,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            searchedList[index].detail ?? '',
                            style: GoogleFonts.raleway(),
                          ),
                          Text(
                            timeFormatter.format(searchedList[index].start!),
                            style: GoogleFonts.raleway(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          searchedList[index].end != null
                              ? Text(
                                  timeFormatter
                                      .format(searchedList[index].end!),
                                  style: GoogleFonts.raleway(
                                      decoration: TextDecoration.none),
                                )
                              : Container(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
