import 'package:eraport/app/modules/connection/views/connectionHome.dart';
import 'package:eraport/app/modules/spalsh/views/spalsh.dart';
import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/login/bindings/login_binding.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () =>  MyConnectionHome(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () =>  SecondScreen(),
      binding: LoginBinding(),
    ),
    
  ];
}
