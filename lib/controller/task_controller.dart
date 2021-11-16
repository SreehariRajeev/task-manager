import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taskmanager/model/task_model.dart';

class TaskController extends GetxController {
  var tasks = <TaskModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    List? savedTasks = GetStorage().read<List>('TASKS');
    if (savedTasks != null) {
      tasks = savedTasks.map((e) => TaskModel.fromJson(e)).toList().obs;
    }
    ever(tasks, (_) => {GetStorage().write('TASKS', tasks.toList())});
  }

  void clearTaskList() {
    GetStorage().erase().obs;
  }
}
