import 'package:la_vie/presentation_layer/shared/constants/constants.dart';

class AllBlogs {
  static String? type;
  static String? message;
  static Map<String,dynamic>? data;
  static List? plants = [];
  static List? seeds = [];
  static List? tools = [];

  AllBlogs.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    data = json['data'] != null ? Map<String,dynamic>.of(json['data']) : null;

        plants=data?['plants'];
        seeds=data?['seeds'];
        tools=data?['tools'];

  }
  ////////////////fetch plants/////////////
  static String getBlogPlantId(index)
  {
    return plants?[index]['plantId'];
  }
  static String getBlogPlantName(index)
  {
      return plants?[index]['name'];
  }
  static String getBlogPlantDescription(index)
  {
    return plants?[index]['description'];
  }
  static String getBlogPlantImage(index)
  {
    if(plants?[index]['imageUrl']==null||plants?[index]['imageUrl']=="")
    {
      return noImage;
    }
    return baseUrl+plants?[index]['imageUrl'];
  }
  static int getBlogPlantWater(index)
  {
    return plants?[index]['waterCapacity'];
  }
  static int getBlogPlantSun(index)
  {
    return plants?[index]['sunLight'];
  }
  static int getBlogPlantTemp(index)
  {
    return plants?[index]['temperature'];
  }
  ////////////////fetch seeds/////////////

  static String getBlogSeedId(index)
  {
    return seeds?[index]['plantId'];
  }
  static String getBlogSeedName(index)
  {
    return seeds?[index]['name'];
  }
  static String getBlogSeedDescription(index)
  {
    return seeds?[index]['description'];
  }
  static String getBlogSeedImage(index)
  {
    if(seeds?[index]['imageUrl']==null||seeds?[index]['imageUrl']=="")
    {
      return noImage;
    }
    return baseUrl+seeds?[index]['imageUrl'];
  }

  ////////////////fetch tools/////////////

  static String getBlogToolId(index)
  {
    return tools?[index]['plantId'];
  }
  static String getBlogToolName(index)
  {
    return tools?[index]['name'];
  }
  static String getBlogToolDescription(index)
  {
    return tools?[index]['description'];
  }
  static String getBlogToolImage(index)
  {
    if(tools?[index]['imageUrl']==null||tools?[index]['imageUrl']=="")
    {
      return noImage;
    }
    return baseUrl+tools?[index]['imageUrl'];
  }


}
