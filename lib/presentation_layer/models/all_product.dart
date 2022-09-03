import 'package:la_vie/presentation_layer/shared/constants/constants.dart';

class AllProductsData {
  static String? type;
  static String? message;
  static List<dynamic>? data = [];
  static String? productId;
  static String? name;
  static String? description;
  static String? newImageUrl;
  static String? imageUrl;
  static String? image;
  static int? price;
  static bool? available;

  AllProductsData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    data = json['data'] != null ? List<dynamic>.of(json['data']) : null;
    data?.forEach((element)
    {
      if (element['type'] == 'SEED') {
        element['seed'].addAll({'amount': 1});

      } else if (element['type'] == 'PLANT') {
        element['plant'].addAll({'amount': 1});

      } else {
        element['tool'].addAll({'amount': 1});

      }
    });
  }
  static String getMainProductId(int index) {
    return productId = data![index]['productId'];
  }

  static String getMainName(int index) {
    return name = data![index]['name'];
  }

  static String getMainDescription(int index) {
    return description = data![index]['description'];
  }

  static String getMainImage(int index) {
    return imageUrl =baseUrl + data![index]['imageUrl'];
  }

  static String getImage(int index) {
    if (data?[index]['type'] == 'PLANT') {
      if (data?[index]['plant']['imageUrl'] == '') {
        return noImage;
      }
      return baseUrl + data?[index]['plant']['imageUrl'];
    } else if (data?[index]['type'] == 'SEED') {
      if (data?[index]['seed']['imageUrl'] == '') {
        return noImage;
      }
      return baseUrl + data?[index]['seed']['imageUrl'];
    } else if (data?[index]['type'] == 'TOOL') {
      if (data?[index]['tool']['imageUrl'] == '') {
        return noImage;
      }
      return baseUrl + data?[index]['tool']['imageUrl'];
    }
    return noImage;
  }

  static String getName(int index) {
    if (data?[index]['type'] == 'PLANT') {
      return data?[index]['plant']['name'];
    } else if (data?[index]['type'] == 'SEED') {
      return data?[index]['seed']['name'];
    } else if (data?[index]['type'] == 'TOOL') {
      return data?[index]['tool']['name'];
    }
    return 'no name';
  }
  static int getNumberOfCard(int index) {
    if (data?[index]['type'] == 'PLANT') {
      return data?[index]['plant']['amount'];
    } else if (data?[index]['type'] == 'SEED') {
      return data?[index]['seed']['amount'];
    } else if (data?[index]['type'] == 'TOOL') {
      return data?[index]['tool']['amount'];
    }
    return 1;
  }

  static int getPrice(int index) {
    return data?[index]['price'];
  }
  static numbOfCard(int number,int index) {
     if (data?[index]['type'] == 'PLANT') {
        data?[index]['plant']['amount']=number;
     } else if (data?[index]['type'] == 'SEED') {
        data?[index]['seed']['amount']=number;
     } else if (data?[index]['type'] == 'TOOL') {
        data?[index]['tool']['amount']=number;
     }
  }
}