class ResponseModel {
  dynamic data;
  bool isSuccess;
  int statusCode;
  String message;

  ResponseModel({
    this.data,
    this.isSuccess,
    this.statusCode,
    this.message,
  });

  ResponseModel fromJson(dynamic jsn) {
    this.statusCode = jsn["statusCode"];
    this.data = jsn["data"];
    this.isSuccess = jsn["isSuccess"];
    this.message = jsn["message"].toString();

    return this;
  }
}
