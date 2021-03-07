class Controller {
  String fullname;
  String validIp;
  String avatar;
  String id;
  String userName;
  String normalizedUserName;
  String email;
  String normalizedEmail;
  String passwordHash;
  String securityStamp;
  String concurrencyStamp;
  String phoneNumber;

  Controller(
      {this.fullname,
        this.validIp,
        this.avatar,
        this.id,
        this.userName,
        this.normalizedUserName,
        this.email,
        this.normalizedEmail,
        this.passwordHash,
        this.securityStamp,
        this.concurrencyStamp,
        this.phoneNumber});

  Controller.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    validIp = json['valid_ip'];
    avatar = json['avatar'];
    id = json['id'];
    userName = json['userName'];
    normalizedUserName = json['normalizedUserName'];
    email = json['email'];
    normalizedEmail = json['normalizedEmail'];
    passwordHash = json['passwordHash'];
    securityStamp = json['securityStamp'];
    concurrencyStamp = json['concurrencyStamp'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['valid_ip'] = this.validIp;
    data['avatar'] = this.avatar;
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['normalizedUserName'] = this.normalizedUserName;
    data['email'] = this.email;
    data['normalizedEmail'] = this.normalizedEmail;
    data['passwordHash'] = this.passwordHash;
    data['securityStamp'] = this.securityStamp;
    data['concurrencyStamp'] = this.concurrencyStamp;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}