import 'package:flulist/src/features/domain/list_model.dart';
import 'package:flulist/src/utils/network/api_base_helper.dart';
import 'package:get/get.dart';

class ListRepository {
  final apiBaseHelper = Get.find<ApiBaseHelper>();

  /// Function used to call the API request to get the list of user data 
  Future<List<ListModel>> getListData() async {
    try {
      const endPoint = 'posts';
      final response = await apiBaseHelper.get(endPoint: endPoint);
      List<ListModel> list = <ListModel>[];
      if (response is List) {
        list.addAll(response.map((e) => ListModel.fromJson(e)).toList());
      }

      return list;
    } on Exception catch (_) {
      rethrow;
    }
  }

  /// Function used to call the API request to get the user data based on `id`
  Future<ListModel> getUserData(int id) async {
    try {
      final endPoint = 'posts/$id';
      final response = await apiBaseHelper.get(endPoint: endPoint);
      ListModel model = ListModel();
      if (response is Map<String, dynamic>) {
        model = ListModel.fromJson(response);
      }
      return model;
    } on Exception catch (_) {
      rethrow;
    }
  }
}
