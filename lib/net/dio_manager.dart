import 'dart:async';
import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:wanandroid/event/error_event.dart';
import 'package:wanandroid/model/base_data.dart';
import 'package:wanandroid/utils/cookieutil.dart';
import 'package:wanandroid/utils/eventbus.dart';

class DioManager {
  Dio _dio;

  static String baseUrl="https://www.wanandroid.com/";

  DioManager._internal() {
    _dio = new Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 10000,
      receiveTimeout: 3000,
    ));
    CookieUtil.getCookiePath().then((path) {
      _dio.interceptors..add(CookieManager(PersistCookieJar(dir: path)));
    });
    _dio.interceptors.add(InterceptorsWrapper(onError: (DioError e) {
      EventUtil.eventBus.fire(e);
      return e;
    }));
  }

  static DioManager singleton = DioManager._internal();

  factory DioManager() => singleton;

  get dio {
    return _dio;
  }

  Future<ResultData> get(url, {data, options, cancelToken}) async {
    print('get请求启动! url：$url ,body: $data');
    Response response;
    ResultData result;
    try {
      response = await dio.get(
        url,
        queryParameters: data,
        options: options,
        cancelToken: cancelToken,
      );
      print('get请求成功!response.data：${response.data}');
      result = ResultData.fromJson(
          response.data is String ? json.decode(response.data) : response.data);
      if (result.errorCode < 0) {
        EventUtil.eventBus.fire(ErrorEvent(result.errorCode, result.errorMsg));
        result = null;
      }
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('get请求取消! ' + e.message);
      }
      print('get请求发生错误：$e');
    }
    return result;
  }

  Future<Response> getNormal(url, {data, options, cancelToken}) async {
    print('get请求启动! url：$url ,body: $data');
    Response response;
    try {
      response = await dio.get(
        url,
        queryParameters: data,
        options: options,
        cancelToken: cancelToken,
      );
      print('get请求成功!response.data：${response.data}');
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('get请求取消! ' + e.message);
      }
      print('get请求发生错误：$e');
    }
    return response;
  }

  Future<ResultData> post(url, {data, options, cancelToken}) async {
    print('post请求启动! url：$url ,body: $data');
    Response response;
    ResultData result;
    try {
      response = await dio.post(
        url,
        queryParameters: data,
        options: options,
        cancelToken: cancelToken,
      );
      print('post请求成功!response.data:${response.data}');
      result = ResultData.fromJson(
          response.data is String ? json.decode(response.data) : response.data);
      if (result.errorCode < 0) {
        EventUtil.eventBus.fire(ErrorEvent(result.errorCode, result.errorMsg));
        result = null;
      }
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('post请求取消! ' + e.message);
      }
      print('post请求发生错误：$e');
    }
    return result;
  }

  Future<Response> postNormal(url, {data, options, cancelToken}) async {
    print('post请求启动! url：$url ,body: $data');
    Response response;
    try {
      response = await dio.post(
        url,
        queryParameters: data,
        options: options,
        cancelToken: cancelToken,
      );
      print('post请求成功!response.data：${response.data}');
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('post请求取消! ' + e.message);
      }
      print('post请求发生错误：$e');
    }
    return response;
  }
}
