import 'package:get/get.dart';

class GetRoute {
  static route(dynamic route, {dynamic arg}) {
    Get.to(route, transition: Transition.cupertino, arguments: arg);
  }
}
