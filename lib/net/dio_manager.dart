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

  DioManager._internal() {
    _dio = new Dio(Options(
      baseUrl: "http://www.wanandroid.com/",
      connectTimeout: 10000,
      receiveTimeout: 3000,
      /*headers: {
        //测试header
        "deviceType": "2.0",
        "deviceOS": "android",
        "deviceOSVersion": "5.1",
        "appVersion": "27",
        "deviceFactory": "OPPO",
        "deviceModel": "OPPO R9tm",
      },*/
    ));
    CookieUtil.getCookiePath().then((path) {
      _dio.cookieJar = PersistCookieJar(dir: path);
    });
    _dio.interceptor.response.onError = (DioError e) {
      // 当请求失败时做一些预处理

      EventUtil.eventBus.fire(e);
      return e; //continue
    };
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
        data: data,
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
        data: data,
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
        data: data,
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
        data: data,
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
