import 'dart:convert';

import 'package:task_manager_new/ApiModels/Controller.dart';
import 'package:task_manager_new/ApiModels/TaskModel2.dart';
import 'package:task_manager_new/ApiModels/UsersList.dart';
import 'package:task_manager_new/ApiModels/detectTaskModel.dart';
import 'package:task_manager_new/ApiModels/ProjectsModel.dart';
import 'package:task_manager_new/ApiModels/UserData.dart';

import '../ApiModels/QueryModel.dart';
import '../ApiModels/Response.dart';
import '../Services/EndPointService.dart';

class ApiServices {
  static List<UserData> UsersList = List<UserData>();
  static List<Controller> controllerList = List<Controller>();
  static List<Project> projectsList = List<Project>();

  Future<UserData> fetchAllUser() async {
    ResponseModel response =
        await EndPointService().SetupApi("", "", []).httpGet(
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (response.isSuccess) {
      for (var item in response.data) {
        if (UserData.fromJson(item) != null)
          UsersList.add(UserData.fromJson(item));
      }
    }
  }

  Future<Controller> fetchController() async {
    ResponseModel response =
        await EndPointService().SetupApi('', '', []).httpGet(
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (response.isSuccess) {
      for (var item in response.data) {
        if (Controller.fromJson(item) != null)
          controllerList.add(Controller.fromJson(item));
      }
    }
  }

  Future setTask() async {
    taskTextModel model = taskTextModel(taskText: "Hello World");
    var json = jsonEncode(model.toJson());

    ResponseModel response = await EndPointService().SetupApi('apptask',
        'TaskDetector', [QueryModel(name: "taskText", value: "hello")]).httpGet(
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (response.isSuccess) {}
  }

  Future fetchProjects() async {
    ResponseModel response =
        await EndPointService().SetupApi("appproject", "", []).httpGet(
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (response.isSuccess) {
      for (var item in response.data) {
        if (Project.fromJson(item) != null)
          projectsList.add(Project.fromJson(item));
      }
    }
  }

  Future<bool> createTask(TaskModel model) async {
    // "description": "ssjsjiosd",
    // "start_date": "2021-03-05",
    // "creator_user_id": "02e491cf-180d-4e66-b164-c55f3784bc66",
    // "master_user_id": "02e491cf-180d-4e66-b164-c55f3784bc66",
    // "manager_user_id": "136ce279-c275-43f2-8a4d-bf4b6a24610f",
    // "linked_contact_id": "136ce279-c275-43f2-8a4d-bf4b6a24610f",
    // "projects": "hell"
    // TaskModel model = TaskModel(
    //     description: "ssjsjiosd",
    //     creatorUserId: "e361abd4-a02c-4adc-bb5b-c74782da0a1f",
    //     masterUserId: "02e491cf-180d-4e66-b164-c55f3784bc66",
    //     startDate: "2021-03-05",
    //     // startTime: "11:26",
    //     // finishDate: "2021-03-08",
    //     // finishTime: "10:26",
    //     managerUserId: 'e361abd4-a02c-4adc-bb5b-c74782da0a1f',
    //     linkedContactId: "136ce279-c275-43f2-8a4d-bf4b6a24610f",////مجری
    //     projects: "hell");
    var json = jsonEncode(model.toJson());

    ResponseModel response =
        await EndPointService().SetupApi("apptask", "", []).httpPost(
      json,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    return response.isSuccess;
  }

  List<UserData> getUsersList() {
    return UsersList;
  }

  List<Controller> getControllersList() {
    return controllerList;
  }

  List<Project> getProjects() {
    return projectsList;
  }
}
