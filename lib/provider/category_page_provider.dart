import 'package:flutter/material.dart';

import '../config/jd_api.dart';
import '../net/net_request.dart';

class CategoryPageProvider with ChangeNotifier{

  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";

  // 將res.data中的值定義為此List
  List<String> categoryNavList = [];

  // 設置一個能暴露給外部接入的接入點
  loadCategoryPageData(){
    isLoading = true;
    isError = false;
    errorMsg = "";

    // 向後端請求數據
    NetRequest().requestData(JdApi.CATEGORY_NAV).then((res){

      // 請求結束後將狀態改為false
      isLoading = false;

      // // 打印出CATEGORY_NAV這個api接口的數據
      // print(res.data);

      // 撈出所有List中的資料
      if (res.data is List){
        for(var i = 0; i < res.data.length; i++){
          categoryNavList.add(res.data[i]);
        }
      }
      // print(categoryNavList);

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