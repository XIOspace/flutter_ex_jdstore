import 'package:dio/dio.dart';

// 這邊加了一個<T>代表多態，允許被調用的時候自動適應父類的抽象類方法
class ComResponse<T> {
  int ?code;
  String ?msg;
  T ?data;

  ComResponse({this.code,this.msg,this.data});
}

class NetRequest {
  var dio = Dio();

  Future<ComResponse<T>> requestData<T>(String path,{
    Map<String,dynamic>? queryParameters,
    dynamic data,
    String method = "get",
  }) async {
    try{
      // final response = await dio.get(path);
      // print(response.data);

      Response response = method == "get"
          ? await dio.get(path,queryParameters: queryParameters)
          : await dio.post(path,data: data);

      // print(response);

      return ComResponse(
        code: response.data["code"],
        msg: response.data["msg"],
        data: response.data["data"],
      );
    } on DioError catch(e){
      // Dio只會返回服務器的錯誤500

      String message = e.message;
      print(message);

      if(e.type==DioErrorType.connectTimeout){
        message = "Connect Timeout";
      }else if(e.type==DioErrorType.receiveTimeout){
        message = "Receive Timeout";
      }else if(e.type==DioErrorType.response){
        message = "404 Not Found ${e.response?.statusCode}";
      }

      return Future.error(message);
    }
  }
}