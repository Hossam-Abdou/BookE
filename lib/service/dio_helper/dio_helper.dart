import 'package:dio/dio.dart';

import '../../utils/end_points/urls.dart';



class DioHelper {

  static Dio? dio;

  static init(){
    dio=Dio(
        BaseOptions(
          baseUrl: EndPoints.baseUrl,
          receiveDataWhenStatusError: true,
        )
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String,dynamic> ?query,
    String? token,
  })
  async {
    dio!.options.headers = {
      'Authorization':'Bearer $token',
      'Accept':'application/json',
    };
    return await dio!.get(
        url,
        queryParameters:query
    );

  }
  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
     Map<String, dynamic>? data,
    String? token,
  }) {

    dio!.options.headers = {
      'Authorization':'Bearer $token',
      'Accept':'application/json',
    };
    return dio!.post(url, queryParameters: query,data: data);
  }
    static Future<Response> putData({
      required String url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      String? token,
    }) {
      dio!.options.headers = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token',
      };
      return dio!.post(url, queryParameters: query, data: data);
    }
  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  })  {
    dio!.options.headers = {
      'Accept': 'application/json',
      'authorization': 'Bearer $token',
    };
    return  dio!.delete(url,queryParameters:query );

  }

  }
