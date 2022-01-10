import 'package:eraport/app/modules/connection/views/connectionHome.dart';
import 'package:eraport/app/modules/spalsh/views/spalsh.dart';
import 'package:get/get.dart';

import '../modules/detail_komen/views/detail_komen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';


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
