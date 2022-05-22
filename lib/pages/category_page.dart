import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/category_page_provider.dart';

class categoryPage extends StatefulWidget {
  const categoryPage({Key? key}) : super(key: key);

  @override
  State<categoryPage> createState() => _categoryPageState();
}

class _categoryPageState extends State<categoryPage> {
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<CategoryPageProvider>(create: (context){
      var provider = new CategoryPageProvider();
      provider.loadCategoryPageData();
      return provider;
    },
      child: Scaffold(
        appBar: AppBar(title: Text('分類'),),
        body: Container(
          color: Color(0xFFf4f4f4),
          child: Consumer<CategoryPageProvider>(builder: (_,provider,__){

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
                          provider.loadCategoryPageData();
                        },
                        child: Text("刷新")
                    )
                  ],
                ),
              );
            }

            // // 打印出provider中
            // print(provider.categoryNavList);

            return Row(
              children: [
                Container(
                  width: 90,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: Container(
                          height: 50.0,
                          padding: const EdgeInsets.only(top: 15),
                          // color: Colors.blue,
                          color: Color(0xFFF8F8F8),
                          child: Text(
                              provider.categoryNavList[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  // color: Colors.red,
                                  color: Color(0xFF333333),
                                  fontWeight: FontWeight.w500
                              )
                          ),
                        ),
                        onTap: (){
                          print(index);
                        },
                      );
                    },
                    itemCount: provider.categoryNavList.length,
                  ),
                )
              ],
            );

          }),
        ),
      ),
    );
  }
}
