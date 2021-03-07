class taskTextModel {
  String taskText;

  taskTextModel({this.taskText});

  taskTextModel.fromJson(Map<String, dynamic> json) {
    taskText = json['taskText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskText'] = this.taskText;
    return data;
  }
}