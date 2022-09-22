import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_states.dart';
import 'package:la_vie/data_layer/cach_helper.dart';
import 'package:la_vie/data_layer/dio/dio.dart';
import 'package:la_vie/presentation_layer/models/all_blogs.dart';
import 'package:la_vie/presentation_layer/models/all_forums.dart';
import 'package:la_vie/presentation_layer/models/all_product.dart';
import 'package:la_vie/presentation_layer/models/get_my_data.dart';
import 'package:la_vie/presentation_layer/models/get_my_forums.dart';
import 'package:la_vie/presentation_layer/screens/home_screen.dart';
import 'package:la_vie/presentation_layer/screens/login_signup_screen.dart';
import 'package:la_vie/presentation_layer/screens/notification_screen.dart';
import 'package:la_vie/presentation_layer/screens/profile_screen.dart';
import 'package:la_vie/presentation_layer/screens/scan_screen.dart';
import 'package:la_vie/presentation_layer/screens/blogs_screen.dart';
import 'package:la_vie/presentation_layer/shared/components/components.dart';
import 'package:la_vie/presentation_layer/shared/constants/constants.dart';
import 'package:sqflite/sqflite.dart';

class GeneralCubit extends Cubit<GeneralStates> {
  GeneralCubit() : super(InitialState());

  static GeneralCubit get(context) => BlocProvider.of(context);

  List<BottomNavigationBarItem> bottomNavBarItem = [
    BottomNavigationBarItem(
      icon: Image.asset(
        'assets/images/leave.png',
        scale: 1.2,
      ),
      label: 'tree',
    ),
    const BottomNavigationBarItem(
      icon: Icon(IconlyLight.scan),
      label: 'scan',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        IconlyLight.home,
        color: Colors.white,
      ),
      label: 'scan',
    ),
    const BottomNavigationBarItem(
      icon: Icon(IconlyLight.notification),
      label: 'Notification',
    ),
    BottomNavigationBarItem(
      icon: Icon(IconlyLight.profile),
      label: 'profile',
    ),
  ];

  List<Widget> screen = [
    BlogsScreen(),
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
  GetMyDataModel? getMyDataModel;
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
      getMyDataModel=GetMyDataModel.fromJson(value.data);
      isLoadProfile = false;
      emit(GetMyDataSuccessState());
    }).catchError((error) {
      isLoadProfile = false;
      emit(GetMyDataErrorState());
    });
  }

  bool isUpdateProfile = false;
  Future<void> updateMyData({
    required String token,
    String? firstName,
    String? lastName,
    String? email,
  }) async{
    isUpdateProfile = true;
    emit(UpdateMyDataLoadingState());
    DioHelper.patchData(
      data:
      {
        'firstName':firstName,
        'lastName':lastName,
        'email':email,
      },
      url: getMe,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    ).then((value) {
      isUpdateProfile = false;
      showToast(message: 'Update Success', toastState: ToastState.success);
      GetMyDataModel.updateData(firstName!,lastName!,email!);
      emit(UpdateMyDataSuccessState());
    }).catchError((error) {
      isUpdateProfile = false;
      showToast(message: 'Check your data', toastState: ToastState.error);
      emit(UpdateMyDataErrorState());
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
      if(AllProductsData.message=="Unauthorized")
      {
        CachHelper.deleteData('token').then((value)
        {
          showToast(
            message: 'Sorry please login again',
            toastState: ToastState.error,
          );
          navigatePushAndFinish(
              context: context,
              navigateTo: LoginScreen(),
          );
          emit(GetAllProductsErrorState());
        });
      }
      print("plaaaaaaaaaaaaaaaants");
      print(AllProductsData.plants);
      print("seeeeeeeeeeeeeeeds");
      print(AllProductsData.seeds);
      print("tooooooooooooools");
      print(AllProductsData.tools);
      getMyData(token: token);
      emit(GetAllProductsSuccessState());
      print('toooooooooooookennn');
      print(CachHelper.getData(key:'token'));
    }).catchError((error)
    {
      emit(GetAllProductsErrorState());
      print(error.toString());
    });
  }

  AllForums? allForums;
  bool isLoadAllForums=false;
  void getAllForums({
    required String token,
    context,
  }) {
    emit(GetAllForumsLoadingState());
    isLoadAllForums=true;
    DioHelper.getData(url: forums, headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    }).then((value) {
      allForums=AllForums.fromJson(value.data);
      print(AllForums.data);
      getMyForums(token: token);
      emit(GetAllForumsSuccessState());
      isLoadAllForums=false;
    }).catchError((error)
    {
      emit(GetAllForumsErrorState());
      isLoadAllForums=false;
      print(error.toString());
    });
  }

  MyForums? myForums;
  bool isLoadMyForums=false;
  void getMyForums({
    required String token,
    context,
  }) {
    emit(GetMyForumsLoadingState());
    isLoadMyForums=true;
    DioHelper.getData(url: myPosts, headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    }).then((value) {
      myForums=MyForums.fromJson(value.data);
      print(MyForums.data);
      emit(GetMyForumsSuccessState());
      isLoadMyForums=false;
    }).catchError((error)
    {
      emit(GetMyForumsErrorState());
      isLoadMyForums=false;
      print(error.toString());
    });
  }

  Future<void> createComment({
    required String token,
    required String comment,
    required String forumId,
    context,
  }) async {
    emit(CreateCommentLoadingState());
    DioHelper.postData(url: "/api/v1/forums/$forumId/comment",
        data:
        {
          'comment':comment,
        },
        headers:
        {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    }).then((value) {
      print(value.data);
      getAllForums(token: token);
      emit(CreateCommentSuccessState());
    }).catchError((error)
    {
      emit(CreateCommentErrorState());
      print(error.toString());
    });
  }

  void putLove({
    required String token,
    required String forumId,
    required int index,
  }) {
    emit(PutLoveLoadingState());
    DioHelper.postData(url: "/api/v1/forums/$forumId/like",
        headers:
        {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }).then((value) {
      emit(PutLoveSuccessState());
    }).catchError((error)
    {
      emit(PutLoveErrorState());
      print(error.toString());
    });
  }

  Future<void> changeLoveButton(index)
  async{
    AllForums.updateIsLove(index,!AllForums.getIsLove(index));
    AllForums.updateForumsNumberOfLikes(index);
    emit(ChangeCardState());
  }


  AllBlogs? allBlogs;
  void getAllBlogs({
    required String token,
    context,
  }) {
    emit(GetAllBlogsLoadingState());
    DioHelper.getData(
        url: blogs,
        headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    }).then((value) {
      allBlogs = AllBlogs.fromJson(value.data);
      print("BBBlooooooooooooooooogssss");
      print(AllBlogs.plants);
      // print(allBlogs!.data!.plants);
      emit(GetAllBlogsSuccessState());
    }).catchError((error) {
      emit(GetAllBlogsErrorState());
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
      if(AllProductsData.getMainProductId(i)==favorites![index]['productId'])
      {
        counterMyCard=AllProductsData.getMainAmountOfCard(i);
        counterMyCard++;
        AllProductsData.updateAmountOfCard(counterMyCard,i);
        updateDataFromDataBase(amount:AllProductsData.getMainAmountOfCard(i),index: index)
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

  bool isCounterZero=false;
  void changeCounterMyCardMinus({required index,context})
  {
    for(int i=0;i<AllProductsData.data!.length;i++)
    {
      if(AllProductsData.getMainProductId(i)==favorites![index]['productId'])
      {
        if(favorites![0]['total']<=0)
        {
          favorites![0]['total']=0;
        }
        counterMyCard=AllProductsData.getMainAmountOfCard(i);
        if(counterMyCard<=1)
        {
          counterMyCard=1;
          isCounterZero=true;

        }else {
          counterMyCard--;
          isCounterZero=false;
        }
        AllProductsData.updateAmountOfCard(counterMyCard,i);
        updateDataFromDataBase(amount:AllProductsData.getMainAmountOfCard(i),index: index)
            .then((value)
        {
          emit(ChangeCardState());
        }).then((value)
        {
          updateTotalFromDataBase(total:isCounterZero?favorites![index]['total']:favorites![index]['total']-favorites![index]['price'],index: index);
        });
      }
    }
  }

  bool inMyCart=false;
  Future<void> checkItemInDataBase({required index})
  async{
    if(favorites!.isEmpty)
    {
      inMyCart=false;
    }
    else
      {
        for(int i=0;i<favorites!.length;++i)
        {
          if(favorites![i]['productId']==getIdOfProduct(index))
          {
            inMyCart=true;
            break;
          }
          else
          {
            inMyCart=false;
          }
        }
      }
  }


  File? profileAvatar;
  String? finalImage;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      profileAvatar = File(image.path.toString());
      final imageBytes = await Io.File(profileAvatar!.path).readAsBytes();
      finalImage = "data:image/png;base64,${base64Encode(imageBytes)}";

      emit(UserSetAvatarState());
    } on PlatformException catch (e) {}
  }

  void clearPickImage()
  {
      profileAvatar=null;
    emit(ClearPickImageState());
  }

  bool isLoadCreatePost=false;
  Future<void> createPost({
    required String token,
    required String title,
    required String description,
    required String photo,
    context,
  }) async {
    emit(CreatePostLoadingState());
    isLoadCreatePost=true;
    DioHelper.postData(url: forums,
        data:
        {
          'title':title,
          'description':description,
          'imageBase64':photo,
        },
        headers:
        {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }).then((value) {
      print(value.data);
      getAllForums(token: token);
      isLoadCreatePost=false;
      emit(CreatePostSuccessState());
      showToast(message: 'post created', toastState: ToastState.success);
    }).catchError((error)
    {
      isLoadCreatePost=false;
      emit(CreatePostErrorState());
      showToast(message: 'error', toastState: ToastState.error);
      print(error.toString());
    });
  }


////////////////dataBase////////////////////
  Database? database;
  List<Map> ?favorites=[];
  Future<void> createDataBase()async
  {
    await openDatabase(
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
      var batch=txn.batch();
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
          showToast(message: 'Added to my cart', toastState: ToastState.success);
        });
      }).catchError((error)
      {
        print('Error when inserting ${error.toString()}');
      });
       batch.commit(noResult: true);

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
     showToast(message: 'Deleted', toastState: ToastState.error);
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
  int selectIndexOfBlog=0;
  void changeSelectIndexOfBlog(int index)
  {
    selectIndexOfBlog=index;
    emit(ChangeSelectIndexSuccessState());
  }
  int selectIndexOfForums=0;
  void changeSelectIndexOfForums(int index)
  {
    selectIndexOfForums=index;
    emit(ChangeSelectIndexSuccessState());
  }
  /////////////filter AllProducts//////////////

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
          return AllProductsData.getMainPrice(index);
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
          return AllProductsData.getMainAmountOfCard(index);
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
          return AllProductsData.getMainProductId(index);
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
          return AllProductsData.updateAmountOfCard(number,index);
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
//////////////////fetch blogs////////////
  String? getBlogName(int index)
  {
    switch(selectIndexOfBlog)
    {
      case 0:
        {
          return AllBlogs.getBlogPlantName(index);
        }
      case 1:
        {
          return AllBlogs.getBlogSeedName(index);
        }
      case 2:
        {
          return AllBlogs.getBlogToolName(index);
        }
    }
    return '';
  }

  String? getBlogImage(int index)
  {
    switch(selectIndexOfBlog)
    {
      case 0:
        {
          return AllBlogs.getBlogPlantImage(index);
        }
      case 1:
        {
          return AllBlogs.getBlogSeedImage(index);
        }
      case 2:
        {
          return AllBlogs.getBlogToolImage(index);
        }
    }
    return '';
  }
  String? getBlogDescription(int index)
  {
    switch(selectIndexOfBlog)
    {
      case 0:
        {
          return AllBlogs.getBlogPlantDescription(index);
        }
      case 1:
        {
          return AllBlogs.getBlogSeedDescription(index);
        }
      case 2:
        {
          return AllBlogs.getBlogToolDescription(index);
        }
    }
    return '';
  }

  getLengthOfBlog()
  {
    switch(selectIndexOfBlog)
    {
      case 0:
        {
          return AllBlogs.plants?.length;
        }
      case 1:
        {
          return AllBlogs.seeds?.length;
        }
      case 2:
        {
          return AllBlogs.tools?.length;
        }
    }
    return 0;
  }
  /////////////////////fetch forums///////////////////

  String? getTitleOfForum(int index)
  {
    switch(selectIndexOfForums)
    {
      case 0:
        {
          return AllForums.getForumTitle(index);
        }
      case 1:
        {
          return MyForums.getForumTitle(index);
        }
    }
    return 'no title';
  }

  String? getDescriptionOfForum(int index)
  {
    switch(selectIndexOfForums)
    {
      case 0:
        {
          return AllForums.getForumDescription(index);
        }
      case 1:
        {
          return MyForums.getForumDescription(index);
        }
    }
    return 'no description';
  }

  String? getIdOfForum(int index)
  {
    switch(selectIndexOfForums)
    {
      case 0:
        {
          return AllForums.getForumId(index);
        }
      case 1:
        {
          return MyForums.getForumId(index);
        }
    }
    return '';
  }

  String? getImageOfForum(int index)
  {
    switch(selectIndexOfForums)
    {
      case 0:
        {
          return AllForums.getForumImage(index);
        }
      case 1:
        {
          return MyForums.getForumImage(index);
        }
    }
    return noImage;
  }

  String? getUserPhotoOfForum(int index)
  {
    switch(selectIndexOfForums)
    {
      case 0:
        {
          return AllForums.getForumUserPhoto(index);
        }
      case 1:
        {
          return MyForums.getForumUserPhoto(index);
        }
    }
    return noImage;
  }

  String? getCommentOfForum(int index,int indexComment)
  {
    switch(selectIndexOfForums)
    {
      case 0:
        {
          return AllForums.getComments(index,indexComment);
        }
      case 1:
        {
          return MyForums.getComments(index,indexComment);
        }
    }
    return '';
  }

  String? getUserFirstNameOfForum(int index)
  {
    switch(selectIndexOfForums)
    {
      case 0:
        {
          return AllForums.getForumUserFirstName(index);
        }
      case 1:
        {
          return MyForums.getForumUserFirstName(index);
        }
    }
    return '';
  }

  String? getUserLastNameOfForum(int index)
  {
    switch(selectIndexOfForums)
    {
      case 0:
        {
          return AllForums.getForumUserLastName(index);
        }
      case 1:
        {
          return MyForums.getForumUserLastName(index);
        }
    }
    return '';
  }

  int? getNumberOfLikesOfForum(int index)
  {
    switch(selectIndexOfForums)
    {
      case 0:
        {
          return AllForums.getForumsNumberOfLikes(index);
        }
      case 1:
        {
          return MyForums.getForumsNumberOfLikes(index);
        }
    }
    return 0;
  }

  int? getNumberOfCommentsOfForum(int index)
  {
    switch(selectIndexOfForums)
    {
      case 0:
        {
          return AllForums.getForumsNumberOfComments(index);
        }
      case 1:
        {
          return MyForums.getForumsNumberOfComments(index);
        }
    }
    return 0;
  }

  getLengthOfForum()
  {
    switch(selectIndexOfForums)
    {
      case 0:
        {
          return AllForums.data!.length;
        }
      case 1:
        {
          return MyForums.data!.length;
        }
    }
    return 0;
  }


}
