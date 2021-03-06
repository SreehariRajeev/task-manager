import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taskmanager/model/group_model.dart';
import 'package:taskmanager/model/task_model.dart';
import 'package:taskmanager/util/appUtil.dart';

class TaskController extends GetxController with AppUtil {
  var taskGroups = <GroupModel>[].obs;
  var tasks = <TaskModel>[].obs;
  var searchedTasks = <TaskModel>[].obs;
  var _navigatorIndex = 0.obs;
  var _startDate = DateTime.now().obs;
  var _endDate = DateTime.now().obs;

  set navigatorIndex(val) => _navigatorIndex = val;
  int get navigatorIndex => _navigatorIndex.value;

  set startDate(val) => _startDate = val;
  DateTime get startDate => _startDate.value;

  set endDate(val) => _endDate = val;
  DateTime get endDate => _endDate.value;

  @override
  void onInit() {
    super.onInit();
    loadGroups();
  }

  //Load Saved Tasks Function
  loadTasks(String groupName) {
    List? savedTasks = GetStorage().read<List>(groupName);
    log(groupName);
    log(savedTasks.toString());
    if (savedTasks != null) {
      tasks = savedTasks.map((e) => TaskModel.fromJson(e)).toList().obs;
    } else {
      tasks.clear();
    }
  }

  //Load Saved Groups Function
  loadGroups() {
    List? groups = GetStorage().read<List>('GROUPS');
    log(groups.toString());
    if (groups != null) {
      taskGroups = groups.map((e) => GroupModel.fromJson(e)).toList().obs;
    } else {
      taskGroups.add(GroupModel(group: 'Home'));
    }
    loadTasks(taskGroups[0].group);
  }

  //Create Group Function
  createTaskGroups(String groupName) {
    taskGroups.add(GroupModel(group: groupName));
    GetStorage().write('GROUPS', taskGroups.toList());
  }

  //Search Tasks Fucntion
  searchTasks(String searchText) {
    log('s');
    List<TaskModel> searchResult = [];
    if (searchText.length >= 3) {
      for (var task in tasks) {
        if (task.title
            .trim()
            .toLowerCase()
            .contains(searchText.trim().toLowerCase())) {
          searchResult.add(task);
        }
      }
      searchedTasks.value = searchResult;
    } else {
      searchedTasks.clear();
    }
  }

  //Add Task Function
  addTask(
      {required String groupName,
      required String taskTitle,
      String? taskDesc,
      DateTime? startDate,
      DateTime? endDate}) {
    tasks.add(TaskModel(
      title: taskTitle,
      detail: taskDesc,
      start: startDate,
      end: endDate,
      isCompleted: false,
    ));

    GetStorage().write(groupName, tasks.toList());
  }

  //Update Task Function
  updateTask(String key) {
    GetStorage().write(key, tasks.toList());
  }

  String checkDate(DateTime date) {
    DateTime now = DateTime.now();
    String displayDate = '';
    if (date.toString().split(' ')[0] == now.toString().split(' ')[0]) {
      displayDate = 'Today';
    } else if (date.toString().split(' ')[0] ==
        DateTime(now.year, now.month, now.day + 1).toString().split(' ')[0]) {
      displayDate = 'Tomorrow';
    } else {
      displayDate = formatter2.format(date);
    }
    return displayDate;
  }

  navigationFunction({required String navigateTo}) {
    int index = navigatorIndex;
    if (navigateTo == 'next') {
      index++;
      navigatorIndex = index.obs;

      loadTasks(getGroupName());
    } else if (navigateTo == 'previous') {
      index--;
      navigatorIndex = index.obs;

      loadTasks(getGroupName());
    }
  }

  bool checkIfSearchedTaskNotEmpty() {
    return searchedTasks.isNotEmpty;
  }

  String getGroupName() {
    return taskGroups[navigatorIndex].group;
  }

  bool checkTaskIsCompleted(int index) {
    return tasks[index].isCompleted;
  }

  bool canGoBackward() {
    return navigatorIndex > 0;
  }

  bool canGoForward() {
    return navigatorIndex + 1 != taskGroups.length;
  }

  clearStorage() {
    GetStorage().erase();
  }
}
