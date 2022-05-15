import 'package:flutter/material.dart';
import 'provider/bottom_navi_provider.dart';
import 'pages/IndexPage.dart';

import 'package:provider/provider.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BottomNaviProvider(),
      child: const MyApp(),
    ),
  );
}

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => BottomNaviProvider()),
//         // Provider(create: (context) => SomeOtherClass()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IndexPage(),
    );
  }
}
