import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:la_vie/presentation_layer/shared/constants/constants.dart';

class DioHelper {
  static late Response response;
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<dynamic> getData({
    String? url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) async {
    return response = await dio!.get(
      url!,
      queryParameters: query,
      options: Options(headers: headers),
    );
  }

  static Future<dynamic> deleteData(
      {String? url,
        Map<String, dynamic>? query,
        Map<String, dynamic>? token}) async {
    return response = await dio!.delete(
      url!,
      queryParameters: query,
      options: Options(headers: token),
    );
  }

  static Future<dynamic> postData({
    required String? url,
    dynamic data,
    Map<String, dynamic>? token,
    Map<String, dynamic>? headers,
  }) async {
    return await dio!.post(
      url!,
      data: data,
      options: Options(headers: headers),
    );
  }

  static Future<dynamic> patchData({
    String? url,
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    return response = (await dio?.patch(url!,
        data:data,
        options: Options(headers: headers)))!;
  }

  static Future<dynamic> patchPassword({
    String? url,
    String? passwordCurrent,
    String? passwordNew,
    String? passwordConfirm,
    String? token,
  }) async {
    return response = (await dio?.patch(url!,
        data: {
          'passwordCurrent': passwordCurrent,
          'password': passwordNew,
          'passwordConfirm': passwordConfirm,
        },
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        })))!;
  }

  static Future<dynamic> uploadImage({
    required String url,
    required File? image,
    required String token,
  }) async {
    /*"name_image": _txtNameImage.text,
      "image": UploadFileInfo(File("$_image"), "image.jpg")*/

    String fileName = image!.path.split('/').last;

    FormData? formData = FormData.fromMap({
      "photo": await MultipartFile.fromFile(
        image.path,
        filename: fileName,
        contentType: MediaType('image', 'png'),
      ),
    });

    return dio!.patch(
      url,
      data: FormData.fromMap({
        'photo': await MultipartFile.fromFile(image.path,
            filename: fileName, contentType: MediaType("image", 'png')),
      }),
      options: Options(headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      }),
    );
  }

}
