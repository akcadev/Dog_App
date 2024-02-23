import 'package:dio/dio.dart';
import 'package:dog_app/api/api_client.dart';

class ApiProvider {
  final ApiClient _client = ApiClient();

  Future<Response> fetchData(String path) {
    return _client.dio.get(path);
  }
  
}
