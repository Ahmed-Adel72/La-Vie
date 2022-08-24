class GetMyDataModel {
  static Map<String, dynamic>? getUserModel;
  static String? userid;
  static String? firstName;
  static String? lastName;
  static String? email;
  static String? photo;



  static String getUserID() {
    return userid = getUserModel!['data']['userId'];
  }

  static String getFirstName() {
    return firstName = getUserModel?['data']['firstName'];
  }

  static String getLastName() {
    return lastName = getUserModel?['data']['lastName'];
  }


  static String getUserEmail() {
    return email = getUserModel!['data']['email'];
  }

  static String? getUserPhoto() {
    return photo = getUserModel?['data']['imageUrl'];
  }

  static void updateName(String firstName) {
    getUserModel!['data']['firstName'] = firstName;
  }

  static void updateEmail(String email) {
    getUserModel!['data']['email'] = email;
  }
}
