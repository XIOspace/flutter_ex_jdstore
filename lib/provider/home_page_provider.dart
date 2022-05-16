import 'package:flutter/material.dart';
import 'package:flutter_ex_jdstore/model/home_page_model.dart';

import '../config/jd_api.dart';
import '../net/net_request.dart';

class HomePageProvider with ChangeNotifier{

  late HomePageModel model;
  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";

  loadHomePageData(){
    isLoading = true;
    isError = false;
    errorMsg = "";
    NetRequest().requestData(JdApi.HOME_PAGE).then((res){
      isLoading = false;
      if(res.code==200){
        print(res.data);
        model = HomePageModel.fromJson(res.data);
      }
      // else{
      //   print(res.msg);
      //   isError = true;
      //   errorMsg = res.msg!;
      // }
      notifyListeners();
    }).catchError((error){
      print(error);
      errorMsg = error;
      isLoading = false;
      isError = true;
      notifyListeners();
    });
  }
}