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
    token=json['accessToken'];
    data = json['data'] != null ? Map<String, dynamic>.of(json['data']) : null;
  }
  static String getUserPhoto()
  {
    return photo=data!['user']['imageUrl'];
  }

  static String getUserEmail()
  {
    return email=data!['user']['email'];
  }

  static String getUserId()
  {
    return userId=data!['user']['userId'];
  }

  // static String getMessage()
  // {
  //   return message=['message'];
  // }





}