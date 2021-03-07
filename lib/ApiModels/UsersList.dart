import 'package:task_manager_new/ApiModels/UserData.dart';

class UsersList {
  List<UserData> data;

  UsersList({this.data});

  UsersList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<UserData>();
      json['data'].forEach((v) {
        data.add(new UserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}