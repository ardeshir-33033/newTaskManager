class TaskResponse {
  String fullName;
  int taskId;
  bool isSuccess;
  String message;

  TaskResponse({this.fullName, this.taskId, this.isSuccess, this.message});

  TaskResponse.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    taskId = json['taskId'];
    isSuccess = json['isSuccess'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['taskId'] = this.taskId;
    data['isSuccess'] = this.isSuccess;
    data['message'] = this.message;
    return data;
  }
}