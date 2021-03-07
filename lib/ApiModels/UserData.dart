class UserData {
  String fullname;
  String identity;
  String avatar;
  String id;
  String userName;
  String email;
  String phoneNumber;

  UserData(
      {this.fullname,
        this.identity,
        this.avatar,
        this.id,
        this.userName,
        this.email,
        this.phoneNumber});

  UserData.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    identity = json['identity'];
    avatar = json['avatar'];
    id = json['id'];
    userName = json['userName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['identity'] = this.identity;
    data['avatar'] = this.avatar;
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}