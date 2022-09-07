import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_states.dart';
import 'package:la_vie/data_layer/cach_helper.dart';
import 'package:la_vie/data_layer/dio/dio.dart';
import 'package:la_vie/presentation_layer/models/all_product.dart';
import 'package:la_vie/presentation_layer/models/get_my_data.dart';
import 'package:la_vie/presentation_layer/screens/home_screen.dart';
import 'package:la_vie/presentation_layer/screens/notification_screen.dart';
import 'package:la_vie/presentation_layer/screens/profile_screen.dart';
import 'package:la_vie/presentation_layer/screens/scan_screen.dart';
import 'package:la_vie/presentation_layer/screens/tree_screen.dart';
import 'package:la_vie/presentation_layer/shared/constants/constants.dart';
import 'package:sqflite/sqflite.dart';

class GeneralCubit extends Cubit<GeneralStates> {
  GeneralCubit() : super(InitialState());

  static GeneralCubit get(context) => BlocProvider.of(context);

  List<BottomNavigationBarItem> bottomNavBarItem = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.pets),
      label: 'tree',
    ),
    BottomNavigationBarItem(
      icon: Icon(IconlyLight.scan),
      label: 'scan',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        IconlyLight.home,
        color: Colors.white,
      ),
      label: 'scan',
    ),
    BottomNavigationBarItem(
      icon: Icon(IconlyLight.notification),
      label: 'Notification',
    ),
    BottomNavigationBarItem(
      icon: Icon(IconlyLight.profile),
      label: 'profile',
    ),
  ];

  List<Widget> screen = [
    TreeScreen(),
    ScanScreen(),
    HomeScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  int currentIndex = 2;
  void changeBottomNAvIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavIndex());
  }

  /////get my data
  bool isLoadProfile = false;
  void getMyData({
    required String token,
  }) {
    isLoadProfile = true;
    emit(GetMyDataLoadingState());
    DioHelper.getData(
      url: getMe,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    ).then((value) {
      GetMyDataModel.getUserModel = Map<String, dynamic>.from(value.data);
      // isLoadProfile = false;
      emit(GetMyDataSuccessState());
      print(GetMyDataModel.email);
    }).catchError((error) {
      emit(GetMyDataErrorState());
    });
  }

  AllProductsData? allProductsData;
  void getAllProducts({
    required String token,
    context,
  }) {
    emit(GetAllProductsLoadingState());
    DioHelper.getData(url: products, headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    }).then((value) {
      allProductsData = AllProductsData.fromJson(value.data);
      print(value.data);
      print("plaaaaaaaaaaaaaaaants");
      print(AllProductsData.plants);
      emit(GetAllProductsSuccessState());
      print(CachHelper.getData(key:'token'));
    }).catchError((error) {
      emit(GetAllProductsErrorState());
      print(error.toString());
    });
  }

  int counter=1;
  void changeCounterCardPlus({required index,}) {
    counter=getAmountOfProduct(index)!;
    counter++;
    updateAmountOfProduct(counter,index);

    emit(ChangeCardState());
  }

  void changeCounterCardMinus({required index,}) {
    counter=getAmountOfProduct(index)!;
    if(counter<=1)
    {
      counter=1;
    }else {
      counter--;
    }
    updateAmountOfProduct(counter,index);
    emit(ChangeCardState());
  }

  int counterMyCard=1;
  void changeCounterMyCardPlus({required index,context})
  {
    for(int i=0;i<AllProductsData.data!.length;i++)
    {
      if(AllProductsData.getProductId(i)==favorites![index]['productId'])
      {
        counterMyCard=AllProductsData.getNumberOfCard(i);
        counterMyCard++;
        AllProductsData.numbOfCard(counterMyCard,i);
        updateDataFromDataBase(amount:AllProductsData.getNumberOfCard(i),index: index)
            .then((value)
        {
          emit((ChangeCardState()));
        }).then((value)
        {
          updateTotalFromDataBase(total:favorites![index]['total']+favorites![index]['price'],index: index);
        });
      }
    }
  }

  void changeCounterMyCardMinus({required index,context})
  {
    for(int i=0;i<AllProductsData.data!.length;i++)
    {
      if(AllProductsData.getProductId(i)==favorites![index]['productId'])
      {
        counterMyCard=AllProductsData.getNumberOfCard(i);
        if(counterMyCard<=1)
        {
          counterMyCard=1;
        }else {
          counterMyCard--;
        }
        AllProductsData.numbOfCard(counterMyCard,i);
        updateDataFromDataBase(amount:AllProductsData.getNumberOfCard(i),index: index)
            .then((value)
        {
          emit(ChangeCardState());
        }).then((value)
        {
          updateTotalFromDataBase(total:favorites![index]['total']-favorites![index]['price'],index: index);
        });
      }
    }
  }

////////////////dataBase////////////////////
  Database? database;
  List<Map> ?favorites=[];
  void createDataBase()
  {
    openDatabase(
      'LaVie.db',
      version: 1,
      onCreate: (database,version)
      {
         database
            .execute(
            'CREATE TABLE LaVie (id INTEGER PRIMARY KEY, photo TEXT, name INTEGER, price INTEGER,amount INTEGER,productId TEXT,total INTEGER)').then((value)
        {
          print('database created');
        }).catchError((error)
        {
          print('Error when created database${error.toString()}');
        });
      },
      onOpen: (database)
      {
        getDataFromDataBase(database).then((value)
        {
          favorites=value;
          print(favorites);
          emit(GetDataBaseSuccessState());
        });
        print('database open');
      },
    ).then((value)
    {
      database=value;
      emit(CreateDataBaseSuccessState());
    });
  }

  Future<void> insertToDataBase(
      {
        String? photo,
        String? name,
        int? price,
        int? amount,
        String? productId,
        int? total,
      })
  async {
    await database!.transaction((txn)
    async{
      await txn.rawInsert('INSERT INTO LaVie(photo,name,price,amount,productId,total) VALUES("$photo","$name","$price","$amount","$productId","$total")')
          .then((value)
      {
        print('$value inserted successfully');
        emit(InsertDataBaseSuccessState());
        getDataFromDataBase(database).then((value)
        {
          favorites=value;
          print(favorites);
          emit(GetDataBaseSuccessState());
        });
      }).catchError((error)
      {
        print('Error when inserting ${error.toString()}');
      });
      return null;
    });
  }

  Future<List<Map>> getDataFromDataBase(database)async
  {
    return await database!.rawQuery('SELECT * FROM LaVie');

  }

  Future<void> deleteDataFromDataBase(
  {
  required int id,
})async
  {
     await database!.rawDelete('DELETE FROM LaVie WHERE id = $id');
     emit(DeleteDataBaseSuccessState());
     getDataFromDataBase(database).then((value)
     {
       favorites=value;
       print(favorites);
       emit(GetDataBaseSuccessState());
     });
  }

  Future<void> updateDataFromDataBase(
      {
        int? amount,
        num? total,
        int? index,
      })async
  {
    await database!.rawUpdate('UPDATE LaVie SET amount = $amount WHERE id=${index!+1}');
    await database!.rawUpdate('UPDATE LaVie SET total = $total');
    emit(UpdateDataBaseSuccessState());
    getDataFromDataBase(database).then((value)
    {
      favorites=value;
      print(favorites);
      emit(GetDataBaseSuccessState());
    });
  }
  Future<void> updateTotalFromDataBase(
      {
        num? total,
        int? index,
      })async
  {
    await database!.rawUpdate('UPDATE LaVie SET total = $total');
    emit(UpdateDataBaseSuccessState());
    getDataFromDataBase(database).then((value)
    {
      favorites=value;
      print(favorites);
      emit(GetDataBaseSuccessState());
    });
  }
/////////////end of dataBase/////////////////

  int selectIndex=0;
  void changeSelectIndex(int index)
  {
    selectIndex=index;
    emit(ChangeSelectIndexSuccessState());
  }
  /////////////filter category//////////////

String? getImageOfProduct(int index)
{
  switch(selectIndex)
  {
    case 0:
      {
        return AllProductsData.getMainImage(index);
      }
    case 1:
      {
        return AllProductsData.getPlantImage(index);
      }
    case 2:
      {
        return AllProductsData.getSeedImage(index);
      }
    case 3:
      {
        return AllProductsData.getToolImage(index);
      }
  }
  return noImage;
}

  String? getNameOfProduct(int index)
  {
    switch(selectIndex)
    {
      case 0:
        {
          return AllProductsData.getMainName(index);
        }
      case 1:
        {
          return AllProductsData.getPlantName(index);
        }
      case 2:
        {
          return AllProductsData.getSeedName(index);
        }
      case 3:
        {
          return AllProductsData.getToolName(index);
        }

    }
    return 'no title';
  }

  int? getPriceOfProduct(int index)
  {
    switch(selectIndex)
    {
      case 0:
        {
          return AllProductsData.getPrice(index);
        }
      case 1:
        {
          return AllProductsData.getPlantPrice(index);
        }
      case 2:
        {
          return AllProductsData.getSeedPrice(index);
        }
      case 3:
        {
          return AllProductsData.getToolPrice(index);
        }
    }
    return 0;
  }

  int? getAmountOfProduct(int index)
  {
    switch(selectIndex)
    {
      case 0:
        {
          return AllProductsData.getNumberOfCard(index);
        }
      case 1:
        {
          return AllProductsData.getPlantAmount(index);
        }
      case 2:
        {
          return AllProductsData.getSeedAmount(index);
        }
      case 3:
        {
          return AllProductsData.getToolAmount(index);
        }
    }
    return 0;
  }

  String? getIdOfProduct(int index)
  {
    switch(selectIndex)
    {
      case 0:
        {
          return AllProductsData.getProductId(index);
        }
      case 1:
        {
          return AllProductsData.getPlantId(index);
        }
      case 2:
        {
          return AllProductsData.getSeedId(index);
        }
      case 3:
        {
          return AllProductsData.getToolId(index);
        }
    }
    return '';
  }

  int? updateAmountOfProduct(int number, int index)
  {
    switch(selectIndex)
    {
      case 0:
        {
          return AllProductsData.numbOfCard(number,index);
        }
      case 1:
        {
          return AllProductsData.updatePlantAmount(number,index);
        }
      case 2:
        {
          return AllProductsData.updateSeedAmount(number,index);
        }
      case 3:
        {
          return AllProductsData.updateToolAmount(number,index);
        }
    }
    return 0;
  }

   getLengthOfProduct()
  {
    switch(selectIndex)
    {
      case 0:
        {
          return AllProductsData.data?.length;
        }
      case 1:
        {
          return AllProductsData.plants?.length;
        }
      case 2:
        {
          return AllProductsData.seeds?.length;
        }
      case 3:
        {
          return AllProductsData.tools?.length;
        }
    }
    return 0;
  }



}
