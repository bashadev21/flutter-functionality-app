import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'home_page.dart';
 
void main()  async{
  await GetStorage.init();
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      transitionDuration: Duration(milliseconds: 900),
      defaultTransition: Transition.cupertino,
      debugShowCheckedModeBanner: false,
      title: 'Functional App',
      home: HomePage(),
    );
  }
}