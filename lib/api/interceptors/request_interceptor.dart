import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

FutureOr<RequestOptions> requestInterceptor(request) async {
  return request;
}

void requestlLogger(RequestOptions request) {
  debugPrint('Url: ${request.method} ${request.uri}\n');
}
