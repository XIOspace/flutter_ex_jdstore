import 'package:flutter/material.dart';
import 'package:flutter_ex_jdstore/model/home_page_model.dart';

import '../config/jd_api.dart';
import '../net/net_request.dart';

class HomePageProvider with ChangeNotifier{

  late HomePageModel model;
  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";

  // 設置一個能暴露給外部接入的接入點
  loadHomePageData(){
    isLoading = true;
    isError = false;
    errorMsg = "";

    // 向後端請求數據
    NetRequest().requestData(JdApi.HOME_PAGE).then((res){

      // 請求結束後將狀態改為false
      isLoading = false;

      if(res.code==200){
        // print(res.data);

        // 將請求的json轉化成map對象
        model = HomePageModel.fromJson(res.data);

        // 改成這樣是為了能把Dart的資料格式轉換回Json格式，方便打印
        // print(model.toJson(model));

        // 修改完HomePageModel之後，去掉報錯的model
        print(model.toJson());

      }
      // 這部分在這沒太多必要，故直接省略
      // else{
      //   print(res.msg);
      //   isError = true;
      //   errorMsg = res.msg!;
      // }

      // 當發生任何變化時，必須要有對應的通知
      notifyListeners();
    }).catchError((error){
      print(error);
      errorMsg = error;
      isLoading = false;
      isError = true;

      // 當發生任何變化時，必須要有對應的通知
      notifyListeners();
    });
  }
}