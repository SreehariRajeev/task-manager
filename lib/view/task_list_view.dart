// ignore_for_file: use_key_in_widget_constructors, must_be_immutable
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmanager/controller/task_controller.dart';
import 'package:taskmanager/model/task_model.dart';
import 'package:taskmanager/util/appUtil.dart';
import 'widgets/custom_widgets.dart';

class TaskManager extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: customAppBar,
      body: TaskGroups(),
    );
  }
}

class TaskGroups extends StatelessWidget with AppUtil {
  final TaskController taskController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,

      body: Column(
        children: [
          //Group Name, Add Group and Navigate Buttons

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Category Name
                CategoryTitleWidget(),

                //Add Group Button and Navigate Arrows
                Row(
                  children: [
                    //Add Category Button
                    AddCategoryBtn(),

                    //Previous Group Button
                    Obx(
                      () => Visibility(
                        visible: taskController.canGoBackward(),
                        child: PreviousBtn(),
                      ),
                    ),

                    //Next Group Button
                    Obx(
                      () => Visibility(
                        visible: taskController.canGoForward(),
                        child: NextBtn(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          //Search Field
          SearchFieldWidget(),

          //View Task and Searched Tasks widget
          Obx(
            () => Visibility(
              visible: taskController.checkIfSearchedTaskNotEmpty(),
              child: Expanded(
                child: SearchResult(
                  searchedList: taskController.searchedTasks,
                ),
              ),
              replacement: Expanded(
                child: Task(
                  groupName: taskController.getGroupName(),
                ),
              ),
            ),
          ),
        ],
      ),

      //Add Tasks Button
      floatingActionButton:
          AddTaskButton(navigatorIndex: taskController.navigatorIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}

//Goto Add_Task Button
class AddTaskButton extends StatelessWidget {
  AddTaskButton({Key? key, required this.navigatorIndex}) : super(key: key);
  final TaskController taskController = Get.find();
  final int navigatorIndex;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Get.toNamed('/add-task', arguments: taskController.getGroupName());
      },
      backgroundColor: Colors.black,
      child: const Icon(Icons.add_task),
    );
  }
}

//Add Category Button
class AddCategoryBtn extends StatelessWidget with AppUtil {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showAddGroupDialog(context);
      },
      icon: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}

//Previous Button
class PreviousBtn extends StatelessWidget {
  PreviousBtn({Key? key}) : super(key: key);
  final TaskController taskController = Get.find();
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        taskController.navigationFunction(navigateTo: 'previous');
      },
      icon: const Icon(
        Icons.navigate_before,
        color: Colors.white,
      ),
    );
  }
}

//Next Button
class NextBtn extends StatelessWidget {
  NextBtn({Key? key}) : super(key: key);
  final TaskController taskController = Get.find();
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        taskController.navigationFunction(navigateTo: 'next');
      },
      icon: const Icon(
        Icons.navigate_next,
        color: Colors.white,
      ),
    );
  }
}

//Task Header Widget
class TaskHeader extends StatelessWidget {
  TaskHeader({Key? key, required this.index}) : super(key: key);
  final TaskController taskController = Get.find();
  final int index;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
                activeColor: Colors.green,
                shape: const CircleBorder(),
                value: taskController.checkTaskIsCompleted(index),
                onChanged: (val) {
                  var changed = taskController.tasks[index];
                  changed.isCompleted = val!;
                  taskController.tasks[index] = changed;
                }),
            Text(
              taskController.tasks[index].title,
              style: GoogleFonts.raleway(
                decoration: !taskController.checkTaskIsCompleted(index)
                    ? TextDecoration.none
                    : TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
        Text(
          taskController.checkDate(taskController.tasks[index].start!),
          style: GoogleFonts.raleway(),
        ),
      ],
    );
  }
}

//Task Widget
class Task extends StatelessWidget with AppUtil {
  Task({required this.groupName});
  final TaskController taskController = Get.find();
  final String groupName;
  @override
  Widget build(BuildContext context) {
    log(taskController.tasks.length.toString());

    return Obx(() {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: taskController.tasks.length,
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
                    title: TaskHeader(index: index),
                    expandedAlignment: Alignment.centerLeft,
                    children: [TaskBody(index: index)],
                  ),
                ),
              ),
            );
          });
    });
  }
}

//Task Body Widget
class TaskBody extends StatelessWidget with AppUtil {
  TaskBody({Key? key, required this.index}) : super(key: key);
  final TaskController controller = Get.find();
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.tasks[index].detail ?? '',
            style: GoogleFonts.raleway(),
          ),
          Text(
            timeFormatter.format(controller.tasks[index].start!),
            style: GoogleFonts.raleway(
              fontWeight: FontWeight.w500,
            ),
          ),
          controller.tasks[index].end != null
              ? Text(
                  timeFormatter.format(controller.tasks[index].end!),
                  style: GoogleFonts.raleway(decoration: TextDecoration.none),
                )
              : Container(),
        ],
      ),
    );
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
