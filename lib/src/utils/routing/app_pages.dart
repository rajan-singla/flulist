import 'package:flulist/src/features/views/my_list_view.dart';
import 'package:flulist/src/features/views/user_data_view.dart';
import 'package:flulist/src/utils/routing/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.homePage,
      page: () => MyListView(),
     ),
     GetPage(
      name: AppRoutes.userDataPage,
      page: () => const UserDataView(),
     ),
  ];
}
