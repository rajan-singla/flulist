import 'package:flulist/src/features/controllers/list_controller.dart';
import 'package:flulist/src/features/domain/list_model.dart';
import 'package:flulist/src/utils/network/api_base_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

class ApiBaseHelperMock extends GetxController
    with Mock
    implements ApiBaseHelper {
  // final json = [
  //       {
  //         "userId": 1,
  //         "id": 1,
  //         "title": "Bakery",
  //         "body": "Buiscuits, Bread etc."
  //       },
  //       {
  //         "userId": 1,
  //         "id": 2,
  //         "title": "Pizza",
  //         "body": "Marghreta, Corn and Onion etc."
  //       }
  //     ];
  // @override
  // Future get(
  //     {required String endPoint, Map<String, dynamic>? queryParameters}) {
  //   return Future.value(json);
  // }
}

void main() {
  late final ApiBaseHelper apiBaseHelper;
  late final ListController controller;

  setUpAll(() {
    apiBaseHelper = Get.put<ApiBaseHelper>(ApiBaseHelperMock());
    controller = Get.put(ListController());
  });

  group('Test List Controller - test list data', () {
    test('check initial values', () {
      final isLoading = controller.isLoading.value;
      final listData = controller.listData;
      expect(isLoading, false);
      expect(listData, <ListModel>[]);
    });

    test('getList data function returns the ListModel list values', () async {
      // Initialise the values
      final json = [
        {
          "userId": 1,
          "id": 1,
          "title": "Bakery",
          "body": "Buiscuits, Bread etc."
        },
        {
          "userId": 1,
          "id": 2,
          "title": "Pizza",
          "body": "Marghreta, Corn and Onion etc."
        }
      ];
      final testListModelList = <ListModel>[
        ListModel(
            id: 1, userId: 1, title: 'Bakery', body: 'Buiscuits, Bread etc.'),
        ListModel(
            id: 2,
            userId: 1,
            title: 'Pizza',
            body: 'Marghreta, Corn and Onion etc.'),
      ];

      //stubbing
      when(() => apiBaseHelper.get(endPoint: 'posts'))
          .thenAnswer((_) => Future.value(json));

      // run
      final value = await controller.getListData();

      // verify
      expect(value, testListModelList);
      verify(() => apiBaseHelper.get(endPoint: 'posts')).called(1);
    });

    test('getList data function throws exception', () async {
      //set up
      when(() => apiBaseHelper.get(endPoint: 'posts'))
          .thenThrow(Exception('connection failed'));

      // verify
      expect(
        () => controller.getListData(),
        throwsException,
      );
    });
  });

  group('Test List Controller - test user data fetched from list using id', () {
    test('get user data', () async {
      // setup
      final json = {
        "userId": 1,
        "id": 1,
        "title": "Bakery",
        "body": "Buiscuits, Bread etc."
      };
      final listModel = ListModel(
          id: 1, userId: 1, title: 'Bakery', body: 'Buiscuits, Bread etc.');
      when(() => apiBaseHelper.get(endPoint: 'posts/1'))
          .thenAnswer((_) => Future.value(json));

      // run
      final value = await controller.getUserData(1);
      expect(value, listModel);
    });

    test('get user data function throws exception', () async {
      //set up
      when(() => apiBaseHelper.get(endPoint: 'posts/1'))
          .thenThrow(Exception('connection failed'));

      // verify
      expect(
        () => controller.getUserData(1),
        throwsException,
      );
    });
  });
}
