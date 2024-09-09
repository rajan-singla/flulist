import 'package:flulist/src/common/app_themed_app_bar.dart';
import 'package:flulist/src/features/controllers/list_controller.dart';
import 'package:flulist/src/features/domain/list_model.dart';
import 'package:flulist/src/utils/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyListView extends GetView<ListController> {
  MyListView({super.key}) {
    Get.put(ListController());
  }

  @override
  Widget build(BuildContext context) {
    Widget showUI(Widget child) {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (controller.listData.isEmpty) {
        return const Center(
          child: Text('No Data Found'),
        );
      } else {
        return child;
      }
    }

    return Scaffold(
      appBar: const AppThemedAppBar(
        title: 'List page',
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        return showUI(const ShowList());
      }),
    );
  }
}

class ShowList extends GetView<ListController> {
  const ShowList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
        return ListView.separated(
          padding: const EdgeInsets.all(10.0),
          separatorBuilder: (_, __) => const SizedBox(
            height: 10.0,
          ),
          itemCount: controller.listData.length,
          itemBuilder: (context, index) {
            final listIndexValue = controller.listData[index];
            return ListTile(
              onTap: listIndexValue.id != null
                  ? () async {
                      final userData =
                          await controller.getUserData(listIndexValue.id!);
                      if (userData != null) {
                        Get.toNamed(AppRoutes.userDataPage,
                            arguments: {'user_data': userData});
                      }
                    }
                  : null,
              leading: Text('${listIndexValue.id}'),
              title: Text(listIndexValue.title ?? ""),
              subtitle: Text(listIndexValue.body ?? ""),
            );
          },
        );
      }
    );
  }
}
