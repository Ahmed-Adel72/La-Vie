import 'package:la_vie/presentation_layer/shared/constants/constants.dart';

class AllProductsData {
  static String? type;
  static String? message;
  static List<dynamic>? data = [];
  static List? plants = [];
  static List? seeds = [];
  static List? tools = [];
  static String? productId;
  static String? name;
  static String? description;
  static String? newImageUrl;
  static String? imageUrl;
  static String? imagePlant;
  static String? image;
  static int? price;
  static bool? available;
  static String? productName;

  AllProductsData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    data = json['data'] != null ? List<dynamic>.of(json['data']) : null;
    data?.forEach((element)
    {
      if (element['type'] == 'SEED') {
        element['seed'].addAll({'amount': 1});
        seeds?.add(
            {
              'image':element['imageUrl'],
              'name':element['name'],
              'price':element['price'],
              'productId':element['productId'],
              'amount':element['seed']['amount'],
            });

      } else if (element['type'] == 'PLANT') {
        element['plant'].addAll({'amount': 1});
        plants?.add(
            {
              'image':element['imageUrl'],
              'name':element['name'],
              'price':element['price'],
              'productId':element['productId'],
              'amount':element['plant']['amount'],
            });

      } else {
        element['tool'].addAll({'amount': 1});
        tools?.add(
            {
              'image':element['imageUrl'],
              'name':element['name'],
              'price':element['price'],
              'productId':element['productId'],
              'amount':element['tool']['amount'],
            });
      }
    });

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

  static int getMainAmountOfCard(int index) {
    if (data?[index]['type'] == 'PLANT') {
      return data?[index]['plant']['amount'];
    } else if (data?[index]['type'] == 'SEED') {
      return data?[index]['seed']['amount'];
    } else if (data?[index]['type'] == 'TOOL') {
      return data?[index]['tool']['amount'];
    }
    return 1;
  }

  static int getMainPrice(int index) {
    return data?[index]['price'];
  }
  static String getMainProductId(int index) {
    return data?[index]['productId'];
  }
  static updateAmountOfCard(int number,int index) {
     if (data?[index]['type'] == 'PLANT') {
        data?[index]['plant']['amount']=number;
        for(int i=0;i<plants!.length;i++)
        {
          if (plants?[i]['productId']==data?[index]['productId']) {
            plants?[i]['amount']=number;
          }
        }
     } else if (data?[index]['type'] == 'SEED') {
        data?[index]['seed']['amount']=number;
        for(int i=0;i<seeds!.length;i++)
        {
          if (seeds?[i]['productId']==data?[index]['productId']) {
            seeds?[i]['amount']=number;
          }
        }
     } else if (data?[index]['type'] == 'TOOL') {
        data?[index]['tool']['amount']=number;
        for(int i=0;i<tools!.length;i++)
        {
          if (tools?[i]['productId']==data?[index]['productId']) {
            tools?[i]['amount']=number;
          }
        }
     }
  }

  ////////////////fetch plants/////////////

  static String getPlantImage(int index)
  {

      return imagePlant=baseUrl + plants?[index]['image'];
  }

  static String getPlantName(int index)
  {
    return plants?[index]['name'];
  }

  static String getPlantId(int index)
  {
    return plants?[index]['productId'];
  }

  static int getPlantPrice(int index)
  {
    return plants?[index]['price'];
  }

  static int getPlantAmount(int index)
  {
    return plants?[index]['amount'];
  }

  static updatePlantAmount(int number,int index)
  {
    plants?[index]['amount']=number;
    for(int i=0;i<data!.length;i++)
    {
      if (data?[i]['productId'] == plants?[index]['productId']) {
        data?[i]['plant']['amount']=number;
      }
    }
  }

////////////////fetch seeds/////////////

  static String getSeedImage(int index)
  {
    return baseUrl + seeds?[index]['image'];
  }

  static String getSeedName(int index)
  {
    return seeds?[index]['name'];
  }

  static String getSeedId(int index)
  {
    return seeds?[index]['productId'];
  }

  static int getSeedPrice(int index)
  {
    return seeds?[index]['price'];
  }

  static int getSeedAmount(int index)
  {
    return seeds?[index]['amount'];
  }

  static updateSeedAmount(int number,int index)
  {
    seeds?[index]['amount']=number;
    for(int i=0;i<data!.length;i++)
    {
      if (data?[i]['productId'] == seeds?[index]['productId']) {
        data?[i]['seed']['amount']=number;
      }
    }
  }

////////////////fetch tools/////////////

  static String getToolImage(int index)
  {
    return baseUrl + tools?[index]['image'];
  }

  static String getToolName(int index)
  {
    return tools?[index]['name'];
  }

  static String getToolId(int index)
  {
    return tools?[index]['productId'];
  }

  static int getToolPrice(int index)
  {
    return tools?[index]['price'];
  }

  static int getToolAmount(int index)
  {
    return tools?[index]['amount'];
  }

  static updateToolAmount(int number,int index)
  {
    tools?[index]['amount']=number;
    for(int i=0;i<data!.length;i++)
    {
      if (data?[i]['productId'] == tools?[index]['productId']) {
        data?[i]['tool']['amount']=number;
      }
    }
  }


}
