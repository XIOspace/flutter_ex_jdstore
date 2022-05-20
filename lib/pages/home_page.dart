import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_ex_jdstore/config/jd_api.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

import '../model/home_page_model.dart';
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

            HomePageModel model = provider.model;

            // return Container();
            return ListView(
              children: [

                // 首頁輪播圖
                  buildAspectRatio(model),
                // 圖標分類
                  buildLogos(model),
                // 秒殺商品頭部
                buildMSHeaderContainer(),
                // 秒殺商品
                buildMSBodyContainer(model),
                // 廣告1
                buildAds(model.pageRow?.ad1),
                // 廣告2
                buildAds(model.pageRow?.ad2),
              ]
            );
          }),
        ),
      ),
    );
  }



  // 首頁輪播圖
  AspectRatio buildAspectRatio(HomePageModel model) {
    return AspectRatio(
                  aspectRatio: 72 / 35,
                  child: Swiper(
                    itemBuilder: (BuildContext context,int index){
                      // return Image.asset("assets/image/jd1.jpg");
                      return Image.asset("assets${model.swipers![index].image}");
                      // return Image.network("http://via.placeholder.com/350x150",fit: BoxFit.fill,);
                    },
                    itemCount: model.swipers?.length,
                    pagination: new SwiperPagination(),
                    control: new SwiperControl(),
                    autoplay: true,
                  ),
                );
  }

  // 圖標分類
  Widget buildLogos(HomePageModel model) {

    // 影片中這樣寫會報錯
    // List<Widget> list = <Widget>[];

    // 訂於list數組 列表容器
    // 改成這樣才ok
    // List<Widget> list = <Widget>[];

    List<Widget> list = <Widget>[];

    // 遍歷model中的logos數組
    for(var i = 0; i < model.logos!.length; i++){
      list.add(
        Container(
          width: 60.0,
          child: Column(
            children: [
              Image.asset(
                "assets${model.logos![i].image}",
                height: 50,
                width: 50,
              ),
              Text("${model.logos![i].title}")
            ],
          ),
        )
      );
    };

    return Container(
      // color: Colors.red,
      color: Colors.white,
      height: 170,
      padding: const EdgeInsets.all(10.0),
      child: Wrap(
        children: list,

        // icon間的左右間隙
        spacing: 7.0,

        // icon間的上下間隙
        runSpacing: 10.0,

        // 讓所有的icon都能平均居中
        alignment: WrapAlignment.spaceBetween,
      ),
    );
  }

  // 秒殺商品頭部
  Container buildMSHeaderContainer() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.all(10.0),
      // color: Colors.red,
      color: Colors.white,
      height: 50,
      child: Row(
        children: [
          Image.asset(
            "assets/image/bej.png",
            width: 90,
            height: 20,
          ),
          Spacer(),
          Text("更多秒殺"),
          Icon(CupertinoIcons.right_chevron,size: 14,)
        ],
      ),
    );
  }

  // 秒殺商品
  Container buildMSBodyContainer(HomePageModel model) {
    return Container(
      height: 120,
      // color: Colors.red,
      color: Colors.white,
      child: ListView.builder(

        // 將整個豎排的商品照片橫過來
          scrollDirection: Axis.horizontal,

          // 設定商匹照片的總數
          itemCount: model.quicks?.length,

          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Image.asset(
                    "assets${model.quicks![index].image}",
                    width: 85,
                    height: 85,
                  ),
                  Text(
                    "${model.quicks![index].price}",
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  // 廣告
  Widget buildAds(List<String>? ads){
    List<Widget> list = <Widget>[];
    for(var i = 0; i < ads!.length; i++){
      list.add(
        Expanded(child: Image.asset("assets${ads[i]}")),
      );
    }

    return Row(
      children: list,
    );
  }
}



//原本官方示範的代碼貼過來確認無誤即可先註解起來
// NetRequest() async {
//   var dio = Dio();
//   final response = await dio.get(JdApi.HOME_PAGE);
//   print(response.data);
// }