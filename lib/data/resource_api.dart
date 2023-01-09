part of 'data.dart';

class ResourceApi {
  static Future<List<ResourceModel>> getResource() async {
    List<ResourceModel> response = <ResourceModel>[];

    try {
      var result = await BaseApi.dio.get(
        '/unknown',
        queryParameters: {'per_page': 20},
      );
      if (result.data['data'] != null) {
        response = result.data['data']
            .map<ResourceModel>((data) => ResourceModel.fromJson(data))
            .toList();
      }
    } catch (e) {
      rethrow;
    }

    return response;
  }
}
