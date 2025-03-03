import 'package:get/get.dart';
import 'package:whereis/screen/item/item_add.dart';
import 'package:whereis/screen/home/home_screen.dart';
import 'package:whereis/screen/item/item_icon.dart';
import 'package:whereis/screen/item/item_location.dart';
import 'package:whereis/screen/login/login_screen.dart';

class PageNavigation {

  static const String login = '/';
  static const String home = '/home';
  static const String add_item = '/item/add';
  static const String select_from_map = '/item/location';
  static const String select_item_icon = '/item/icon';
  static const String update_item = '/item/update';

  static final routes = [
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: add_item, page: () => ItemAdd()),
    GetPage(name: select_from_map, page: () => ItemLocation()),
    GetPage(name: select_item_icon, page: () => ItemIcon()),
    GetPage(name: update_item, page: () {
      final item = Get.parameters['id'];
      return ItemAdd(itemId: item);
    })
  ];

}