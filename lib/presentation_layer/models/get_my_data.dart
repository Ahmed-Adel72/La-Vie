import 'package:la_vie/presentation_layer/shared/constants/constants.dart';

class GetMyDataModel {
  static String? type;
  static String? message;
  static Map<String, dynamic>? data;
  static List? notifications=[];
  static String? userid;
  static String? firstName;
  static String? lastName;
  static String? email;
  static String? photo;

  GetMyDataModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    data = json['data'] != null ? Map<String, dynamic>.of(json['data']) : null;
  }


  static String getUserID() {
    return userid = data!['userId'];
  }

  static String getFirstName() {
    return firstName = data?['firstName'];
  }

  static String getLastName() {
    return lastName = data?['lastName'];
  }


  static String getUserEmail() {
    return email = data!['email'];
  }

  static String? getUserPhoto() {
    if(data?['imageUrl']==null||data?['imageUrl']=='')
    {
      return noImage;
    }
    return photo = data?['imageUrl'];
  }

  static int? getUserPoints() {
    if(data?['UserPoints']==null||data?['UserPoints']=='')
    {
      return 0;
    }
    return photo = data?['UserPoints'];
  }

  static void updateData(String firstName,String lastName,String email) {
    data!['firstName'] = firstName;
    data!['lastName'] = lastName;
    data!['email'] = email;
  }

}
