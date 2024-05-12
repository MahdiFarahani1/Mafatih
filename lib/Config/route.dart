import 'package:get/get.dart';

class GetRoute {
  static route(dynamic route) {
    Get.to(route, transition: Transition.cupertino);
  }
}
