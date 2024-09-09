import 'package:flulist/src/common/app_themed_app_bar.dart';
import 'package:flulist/src/features/domain/list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDataView extends StatelessWidget {
  const UserDataView({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    if (arguments == null || arguments['user_data'] == null) {
      return const Center(
        child: Text('No Data Found'),
      );
    }

    final userData = arguments['user_data'] as ListModel;

    return Scaffold(
      appBar: AppThemedAppBar(title: '${userData.id}'),
      body: Center(
        child: ListTile(
          contentPadding: const EdgeInsets.all(10.0),
          title: Text(userData.title ?? ""),
          subtitle: Text(userData.body ?? ""),
        ),
      ),
    );
  }
}
