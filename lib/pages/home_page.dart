import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_ex_jdstore/config/jd_api.dart';

import '../net/net_request.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {

    //原本官方示範的代碼貼過來確認無誤即可先註解起來
    // NetRequest();

    // 原本的
    // NetRequest().requestData(JdApi.HOME_PAGE);

    // 改這樣即可打印
    // var data = NetRequest().requestData(JdApi.HOME_PAGE);
    // print(data);

    // 最後改這樣
    NetRequest().requestData(JdApi.HOME_PAGE).then((res) => print(res.data));


    return Scaffold(
      appBar: AppBar(
        title: Text('主頁'),
      ),
    );
  }
}

//原本官方示範的代碼貼過來確認無誤即可先註解起來
// NetRequest() async {
//   var dio = Dio();
//   final response = await dio.get(JdApi.HOME_PAGE);
//   print(response.data);
// }