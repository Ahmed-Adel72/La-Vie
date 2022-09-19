import 'package:la_vie/presentation_layer/shared/constants/constants.dart';

class MyForums {
  static String? type;
  static String? message;
  static List<dynamic>? data;
  static List? forumLikes = [];
  static List? forumComments = [];
  static Map<String, dynamic>? user;

  MyForums.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    data = json['data'] != null ? List<dynamic>.of(json['data']) : null;
    data?.forEach((element)
    {
      element.addAll({'isLove':false});
    });
  }


  static String getForumId(index)
  {
    return data?[index]['forumId'];
  }
  static String getForumTitle(index)
  {
    return data?[index]['title'];
  }
  static String getForumDescription(index)
  {
    return data?[index]['description'];
  }
  static String getForumImage(index)
  {
    if(data?[index]['imageUrl']==""||data?[index]['imageUrl']==null)
    {
      return noImage;
    }
    return baseUrl+ data?[index]['imageUrl'];
  }
  static String getForumUserId(index)
  {
    return data?[index]['userId'];
  }

  static String getForumUserFirstName(index)
  {
    return data?[index]['user']['firstName'];
  }
  static String getForumUserLastName(index)
  {
    return data?[index]['user']['lastName'];
  }
  static String getForumUserPhoto(index)
  {
    return data?[index]['user']['imageUrl'];
  }


  static int? getForumsNumberOfLikes(index)
  {
    return data?[index]['ForumLikes'].length;
  }
  static int? updateForumsNumberOfLikes(index)
  {
    return data?[index]['ForumLikes'].length++;
  }
  static bool getIsLove(index)
  {
    return data?[index]['isLove'];
  }
  static bool? updateIsLove(index,isLove)
  {
    return data?[index]['isLove']=isLove;
  }
  static int? getForumsNumberOfComments(index)
  {
    return data?[index]['ForumComments'].length;
  }
  static String getComments(index,indexComment)
  {
    return data?[index]['ForumComments'][indexComment]['comment'];
  }



}