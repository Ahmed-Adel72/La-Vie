class UserLoginModel {
  static String? message;
  static Map<String,dynamic>? data;
  static String? firstName;
  static String? lastName;
  static String? userId;
  static String? email;
  static String? token;
  static String? photo;

  UserLoginModel.fromJson(Map<String,dynamic>json)
  {
    message=json['message'];
    token=json['data']['accessToken'];
    data = json['data'] != null ? Map<String, dynamic>.of(json['data']) : null;
  }

}