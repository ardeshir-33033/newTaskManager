class TaskModel {
  String description;
  String startDate;
  String finishDate;
  String deadDate;
  String startTime;
  String finishTime;
  String deadTime;
  String creatorUserId;
  String masterUserId;
  String managerUserId;
  String userAcceptedAdminId;
  String userAcceptedTargetId;
  String linkedContactId;
  String projects;

  TaskModel(
      {this.description,
        this.startDate,
        this.finishDate,
        this.deadDate,
        this.startTime,
        this.finishTime,
        this.deadTime,
        this.creatorUserId,
        this.masterUserId,
        this.managerUserId,
        this.userAcceptedAdminId,
        this.userAcceptedTargetId,
        this.linkedContactId,
        this.projects});

  TaskModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    startDate = json['start_date'];
    finishDate = json['finish_date'];
    deadDate = json['dead_date'];
    startTime = json['start_time'];
    finishTime = json['finish_time'];
    deadTime = json['dead_time'];
    creatorUserId = json['creator_user_id'];
    masterUserId = json['master_user_id'];
    managerUserId = json['manager_user_id'];
    userAcceptedAdminId = json['user_accepted_admin_id'];
    userAcceptedTargetId = json['user_accepted_target_id'];
    linkedContactId = json['linked_contact_id'];
    projects = json['projects'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['start_date'] = this.startDate;
    data['finish_date'] = this.finishDate;
    data['dead_date'] = this.deadDate;
    data['start_time'] = this.startTime;
    data['finish_time'] = this.finishTime;
    data['dead_time'] = this.deadTime;
    data['creator_user_id'] = this.creatorUserId;
    data['master_user_id'] = this.masterUserId;
    data['manager_user_id'] = this.managerUserId;
    data['user_accepted_admin_id'] = this.userAcceptedAdminId;
    data['user_accepted_target_id'] = this.userAcceptedTargetId;
    data['linked_contact_id'] = this.linkedContactId;
    data['projects'] = this.projects;
    return data;
  }
}