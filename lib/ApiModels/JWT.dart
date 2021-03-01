class JwtModel {
  String access_token;
  String token_type;
  int expires_in;

  JwtModel({
    this.access_token,
    this.token_type,
    this.expires_in,
  });

  JwtModel fromJson(dynamic jsn) {
    this.access_token = jsn["access_token"];
    this.expires_in = jsn["expires_in"];
    this.token_type = jsn["token_type"];

    return this;
  }

  Map<String, dynamic> toJson() => {
    'access_token': access_token,
    'token_type': token_type,
    'expires_in': expires_in
  };
}
