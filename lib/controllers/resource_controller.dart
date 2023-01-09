part of 'controllers.dart';

class ResourceController extends GetxController {
  static ResourceController to = Get.find();

  final listResource = <ResourceModel>[].obs;

  final isLoadingResource = false.obs;

  Future<List<ResourceModel>> getResource(BuildContext context) async {
    List<ResourceModel> response = <ResourceModel>[];

    isLoadingResource.value = true;
    try {
      response = await ResourceApi.getResource();

      if (response.isNotEmpty) {
        listResource.value = response;
      }
    } catch (error) {
      isLoadingResource.value = false;
      Get.snackbar(
        "Error",
        "Error on getResource",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } finally {
      isLoadingResource.value = false;
    }

    return response;
  }
}
