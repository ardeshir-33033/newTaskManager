class Project {
  String name;
  int parentId;
  String title;
  String description;
  String startTime;
  String finishTime;
  int teamId;
  String creatorId;
  String managerId;
  int profileId;
  int id;
  String creationDateTime;
  String creationPersianDateTime;
  int priority;
  String userCreatedId;
  String systemTag;

  Project(
      {this.name,
        this.parentId,
        this.title,
        this.description,
        this.startTime,
        this.finishTime,
        this.teamId,
        this.creatorId,
        this.managerId,
        this.profileId,
        this.id,
        this.creationDateTime,
        this.creationPersianDateTime,
        this.priority,
        this.userCreatedId,
        this.systemTag});

  Project.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    parentId = json['parentId'];
    title = json['title'];
    description = json['description'];
    startTime = json['startTime'];
    finishTime = json['finishTime'];
    teamId = json['teamId'];
    creatorId = json['creatorId'];
    managerId = json['managerId'];
    profileId = json['profileId'];
    id = json['id'];
    creationDateTime = json['creationDateTime'];
    creationPersianDateTime = json['creationPersianDateTime'];
    priority = json['priority'];
    userCreatedId = json['userCreatedId'];
    systemTag = json['systemTag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['parentId'] = this.parentId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['startTime'] = this.startTime;
    data['finishTime'] = this.finishTime;
    data['teamId'] = this.teamId;
    data['creatorId'] = this.creatorId;
    data['managerId'] = this.managerId;
    data['profileId'] = this.profileId;
    data['id'] = this.id;
    data['creationDateTime'] = this.creationDateTime;
    data['creationPersianDateTime'] = this.creationPersianDateTime;
    data['priority'] = this.priority;
    data['userCreatedId'] = this.userCreatedId;
    data['systemTag'] = this.systemTag;
    return data;
  }
}