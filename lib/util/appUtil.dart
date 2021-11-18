// ignore_for_file: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager/controller/task_controller.dart';

mixin AppUtil {
  DateFormat formatter = DateFormat('EEE, dd-M-yyyy hh:mm aa');
  DateFormat timeFormatter = DateFormat('hh:mmaa');
  DateFormat formatter2 = DateFormat('dd-MMM-yyyy');
  showAddGroupDialog(BuildContext context) {
    final groupNameCtrl = TextEditingController();
    final TaskController taskController = Get.find();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.blueGrey,
        title: Text(
          'Add Category',
          style: GoogleFonts.raleway(
              fontWeight: FontWeight.w600, color: Colors.white),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
        content: Material(
          elevation: 6,
          shadowColor: Colors.grey[300],
          borderRadius: BorderRadius.circular(6),
          child: TextFormField(
            autofocus: true,
            controller: groupNameCtrl,
            decoration: InputDecoration(
                hintText: 'Category',
                isDense: true,
                hintStyle: GoogleFonts.raleway(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                border: const OutlineInputBorder(borderSide: BorderSide.none)),
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.black),
            onPressed: () {
              taskController.createTaskGroups(groupNameCtrl.text);
              groupNameCtrl.clear();
              Get.back();
            },
            child: Text(
              'Add',
              style: GoogleFonts.raleway(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
