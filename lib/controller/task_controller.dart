import 'package:get/get.dart';
import 'package:taskmanager/model/task_model.dart';

class TaskController extends GetxController {
  var tasks = <TaskModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  void fetchTasks() async {
    await Future.delayed(const Duration(seconds: 2));
    final taskList = [
      TaskModel(taskTitle: 'HOME', subtaskList: [
        SubtaskList(
          subtaskTitle: 'Get Laundry',
          subtaskDetail: 'Get laundty from brooks dry cleaners',
          subtaskStart: DateTime(2021, 11, 15, 13, 15),
          subtaskEnd: DateTime(2021, 11, 15, 13, 15),
        ),
        SubtaskList(
          subtaskTitle: 'Buy Milk',
          subtaskDetail: 'Buy milk from more',
          subtaskStart: DateTime(2021, 11, 15, 14, 45),
          subtaskEnd: DateTime(2021, 11, 15, 14, 45),
        ),
        SubtaskList(
          subtaskTitle: 'Pick Rom',
          subtaskDetail: 'Pick Ron from school',
          subtaskStart: DateTime(2021, 11, 15, 17, 30),
          subtaskEnd: DateTime(2021, 11, 15, 17, 30),
        )
      ])
    ];
    tasks.value = taskList;
  }
}
