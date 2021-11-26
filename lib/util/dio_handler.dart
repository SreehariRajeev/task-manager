import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:taskmanager/model/user_model.dart';

class DioClient {
  final Dio _dio = Dio();

  final String _baseUrl = "https://reqres.in/api/";

  Future<UserModel> getUser(String id) async {
    UserModel? user;
    try {
      Response userData = await _dio.get(_baseUrl + '/users/$id');
      user = UserModel.fromJson(userData.data);
    } on DioError catch (e) {
      if (e.response != null) {
        log("Dio Error! \n Status : ${e.response?.statusCode} \n Data : ${e.response?.data}");
      } else {
        log("Error sending requests");
        log(e.message);
      }
    }

    return user!;
  }
}
