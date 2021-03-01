import 'package:dio/dio.dart';
import 'package:task_manager_new/ApiModels/QueryModel.dart';
import 'package:task_manager_new/ApiModels/TaskModel.dart';

import 'EndPointService.dart';

class TaskServiceEndPoint {
  static String Token;
  static int TaskId;

  Future<void> uploadTask(TaskModel data) async {
    TaskId = null;
    try {
      Dio dio = new Dio();

      var fd = FormData.fromMap({
        "Description": data.Description,
        "Creator_user_id": data.Creator_user_id,
      });
      String url = "https://dinavision.org/TaskHome/CreateTaskForMobile";
      var response = await dio.post(
        url,
        data: fd,
      );

      if (response.data["isSuccess"] == true) {
        TaskId = response.data["taskId"];
        // return response.data["isSuccess"];
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> login(String email) async {
    Token = await EndPointService().SetupApi(
        "getuserId", "", [QueryModel(name: "email", value: email)]).httpGet2(
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (Token != '') {
      return Token;
    }
  }
  String getToken(){
    return Token;
  }
  int getTaskId(){
    return TaskId;
  }
}
