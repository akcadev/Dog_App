import 'package:dio/dio.dart';
import 'package:dog_app/utils/constants.dart';

class ApiClient {
  final Dio dio = Dio();

  ApiClient() {
    dio.options.baseUrl = Constants.baseUrl;
  }
}
