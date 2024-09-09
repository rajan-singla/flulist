import 'package:flulist/src/features/data/list_repository.dart';
import 'package:flulist/src/features/domain/list_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ListController extends GetxController {
  late final ListRepository listRepository;

  /// To show the loader at the time async calls
  RxBool isLoading = false.obs;
  RxList<ListModel> listData = <ListModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    listRepository = ListRepository();
  }

  @override
  void onReady() {
    super.onReady();
    // Fetching the list of user data
    getListData();
  }

  /// Function used to get list of user data.
  Future<List<ListModel>> getListData() async {
    try {
      isLoading.value = true;
      listData.value = await listRepository.getListData();
      return listData;
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  /// Function used to get the user data based on user id.
  Future<ListModel?> getUserData(int id) async {
    try {
      isLoading.value = true;
      final model = await listRepository.getUserData(id);
      return model;
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
