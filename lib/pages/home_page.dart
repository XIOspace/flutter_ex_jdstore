import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_ex_jdstore/config/jd_api.dart';
import 'package:provider/provider.dart';

import '../net/net_request.dart';
import '../provider/home_page_provider.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {

    // 下方原本請求數據的方法直接註解home_page_provider.dart處理

    //原本官方示範的代碼貼過來確認無誤即可先註解起來
    // NetRequest();

    // 原本的
    // NetRequest().requestData(JdApi.HOME_PAGE);

    // 改這樣即可打印
    // var data = NetRequest().requestData(JdApi.HOME_PAGE);
    // print(data);

    // 最後改這樣
    // NetRequest().requestData(JdApi.HOME_PAGE).then((res) => print(res.data));

    // 這部分必須改寫，因為要接入HomePageProvider
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('主頁'),
    //   ),
    // );
    
    return ChangeNotifierProvider<HomePageProvider>(create: (context){
        var provider = new HomePageProvider();
        provider.loadHomePageData();
        return provider;
      },
      child: Scaffold(
        appBar: AppBar(title: Text('首頁'),),
        body: Container(
          color: Color(0xFFf4f4f4),
          child: Consumer<HomePageProvider>(builder: (_,provider,__){

            // // 打印出加載狀態，加載前為true，加載完成為false
            // print(provider.isLoading);

            // 加載資料的時候顯示的轉圈動畫
            if(provider.isLoading){
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }

            // 捕獲異常 當無法連接後端資料時，跳出錯誤並顯示刷新按鈕
            if(provider.isError){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(provider.errorMsg),
                    OutlinedButton(
                        onPressed: (){
                          provider.loadHomePageData();
                        },
                        child: Text("刷新")
                    )
                  ],
                ),
              );
            }

            return Container();
          }),
        ),
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