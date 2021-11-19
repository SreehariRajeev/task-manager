import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmanager/controller/task_controller.dart';
import 'package:taskmanager/model/task_model.dart';
import 'package:taskmanager/util/appUtil.dart';
import 'package:taskmanager/view/styles/text_field_decoration.dart';

//Search Tasks Widget
class SearchFieldWidget extends StatelessWidget with CustomDecoration {
  SearchFieldWidget({Key? key}) : super(key: key);

  final TaskController taskController = Get.find();
  final TextEditingController _searchCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _searchCtrl,
        style: GoogleFonts.raleway(color: Colors.white),
        textInputAction: TextInputAction.search,
        onChanged: (_) {
          taskController.searchTasks(_searchCtrl.text);
        },
        decoration: searchFieldDecoration(hintTextStr: 'Search Tasks'),
      ),
    );
  }
}

//AppBar Widget
PreferredSizeWidget customAppBar = AppBar(
    backgroundColor: Colors.black,
    title: Text(
      'Task Manager',
      style: GoogleFonts.raleway(),
    ));

//Category Header
Widget categoryTitleWidget({required String title}) {
  return Text(title,
      style: GoogleFonts.raleway(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ));
}

class CategoryTitleWidget extends StatelessWidget {
  const CategoryTitleWidget({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: GoogleFonts.raleway(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w400,
        ));
  }
}
