import 'package:get/get.dart';
import 'package:taskmanager/model/user_model.dart';
import 'package:taskmanager/util/dio_handler.dart';

class UserController extends GetxController {
  UserModel? user;

  loginUser(String id) async {
    DioClient client = DioClient();

    user = await client.getUser(id);
    update();
  }
}
