import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/bottom_navi_provider.dart';
import 'cart_page.dart';
import 'category_page.dart';
import 'home_page.dart';
import 'user_page.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);


  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  // int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:Consumer<BottomNaviProvider>(
        builder: (_, mProvider, __) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            // currentIndex: _currentIndex,
            currentIndex: mProvider.bottomNaviIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                // title: Text("首頁"),
                label: "首頁",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                // title: Text("首頁"),
                label: "分類",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                // title: Text("首頁"),
                label: "購物車",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                // title: Text("首頁"),
                label: "我的",
              ),
            ],
            onTap: (index){
              // // print(index);
              // setState(() {
              //   _currentIndex = index;
              // });
              mProvider.changeBottomNaviIndex(index);
            },
            );
          },
      ),
      // body: Text('Hey'),
      body: Consumer<BottomNaviProvider>(
        builder: (_, mProvider, __) {
          return IndexedStack(
            // index: _currentIndex,
            index: mProvider.bottomNaviIndex,
            children: [
              homePage(),
              categoryPage(),
              cartPage(),
              userPage(),
            ],
          );
        },
      ) //可承載多個Widget，但一次只顯示一個Widget，為層佈局控件
    );
  }
}
