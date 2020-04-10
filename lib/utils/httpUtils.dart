import 'package:dio/dio.dart';
import 'package:flutter_shop/config/web.config.dart';

class HttpUtil {
  static HttpUtil instance;
  static Dio dio;
  BaseOptions options;

  CancelToken cancelToken = CancelToken();

  static HttpUtil getInstance() {
    if(instance == null) instance = HttpUtil();
    return instance;
  }

  HttpUtil() {
    options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 10000,
      receiveTimeout: 5000,
      headers: {
          "version": "1.0.0"
      },
      contentType: Headers.formUrlEncodedContentType,
      responseType: ResponseType.json
    );
    dio = Dio(options);
       //添加拦截器
    dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      print("请求之前");
      // Do something before request is sent
      return options; //continue
    }, onResponse: (Response response) {
      print("响应之前");
      // Do something with response data
      return response; // continue
    }, onError: (DioError e) {
      print("错误之前");
      // Do something with response error
      return e; //continue
    }));
  }
  setToken(String token) {
    BaseOptions options = new BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'x-token': token,
      },
    );
    Dio req = new Dio(options);
    // 添加拦截器
    req.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      return options; //continue
    }, onResponse: (Response response) {
      if (response.data['errno'] == 0) {
        return response.data;
      } else {
        return null;
      }
    }, onError: (DioError e) {
      print(e);
      return e; //continue
    }));
    return req;
  }
  get(url, {data, options, cancelToken}) async {
    Response response;
    try {
      response = await dio.get(url,queryParameters: data, options: options,cancelToken: cancelToken);
      print('get success---------${response.statusCode}');
      print('get success---------${response.data}');
    } on DioError catch (e) {
      print('get error------$e');
      formatError(e);
    }
    return response.data;
  }
  
  post(url, {data, options, cancelToken}) async {
    Response response;
    try {
      response = await dio.post(url,data: data, options: options,cancelToken: cancelToken);
      print('post success---------${response.statusCode}');
    } on DioError catch (e) {
      print('post error------$e');
      formatError(e);
    }
    return response.data;
  }
  postToken(String url,String token,{data, options,cancelToken}) async {
    Response response;
    Dio req = setToken(token);
    try {
      response = await req.post(url,data: data, options: options,cancelToken: cancelToken);
      print('post success---------${response.statusCode}');
    } on DioError catch (e) {
      print('post error------$e');
      formatError(e);
    }
    return response.data;
  }
  patch(url, {data, options, cancelToken}) async {
    Response response;
    try {
      response = await dio.patch(url,queryParameters: data, options: options,cancelToken: cancelToken);
      print('patch success---------${response.statusCode}');
      print('patch success---------${response.data}');
    } on DioError catch (e) {
      print('patch error------$e');
      formatError(e);
    }
    return response.data;
  }
  delete(url, {data, options, cancelToken}) async {
    Response response;
    try {
      response = await dio.delete(url,queryParameters: data, options: options,cancelToken: cancelToken);
      print('post success---------${response.statusCode}');
      print('post success---------${response.data}');
    } on DioError catch (e) {
      print('delete error------$e');
      formatError(e);
    }
    return response.data;
  }  
}

 /*
   * error统一处理
   */
  void formatError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      // It occurs when url is opened timeout.
      print("连接超时");
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      // It occurs when url is sent timeout.
      print("请求超时");
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      //It occurs when receiving timeout
      print("响应超时");
    } else if (e.type == DioErrorType.RESPONSE) {
      // When the server response, but with a incorrect status, such as 404, 503...
      print("出现异常");
    } else if (e.type == DioErrorType.CANCEL) {
      // When the request is cancelled, dio will throw a error with this type.
      print("请求取消");
    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      print("未知错误");
    }
  }
