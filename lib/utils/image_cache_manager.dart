import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ImageCacheManager {
  static final ImageCacheManager _instance = ImageCacheManager._internal();

  factory ImageCacheManager() {
    return _instance;
  }

  ImageCacheManager._internal();

  final Map<String, bool> _imageCache = {}; // Görüntü ön belleği
  final LinkedHashMap<String, Image> loadedImages =
      LinkedHashMap(); // Yüklenen görüntüler

  final int _maxCacheSize = 100; // Maksimum önbellek boyutu

  // Özel ön bellekleme işlemi
  Future<void> precacheImage(String imageUrl) async {
    if (!_imageCache.containsKey(imageUrl)) {

      // Önbelleğe alındı olarak işaretle
      _imageCache[imageUrl] = true;

      // Maksimum önbellek boyutunu kontrol et
      if (loadedImages.length >= _maxCacheSize) {
        // Maksimum boyuta ulaşıldığında en eski öğeyi kaldır
        final String oldestImageUrl = loadedImages.keys.first;
        loadedImages.remove(oldestImageUrl);
      }

      // Görüntüyü yükle ve önbelleğe ekle
      final Image image = await _loadImage(imageUrl);
      loadedImages[imageUrl] = image;
    }
  }

  // Görüntü yükleme işlemi
  Future<Image> _loadImage(String imageUrl) async {
    final Completer<Image> completer = Completer();
    Dio dio = Dio();
    Response<List<int>> response = await dio.get<List<int>>(imageUrl,
        options: Options(responseType: ResponseType.bytes));

    if (response.statusCode == 200) {
      Uint8List bytes = Uint8List.fromList(response.data!);

      final Image image = Image.memory(
        bytes,
        width: 150,
        height: 150,
        cacheHeight: 150,
        cacheWidth: 150,
        filterQuality: FilterQuality.low,
        fit: BoxFit.cover,
      );
      completer.complete(image);
    } else {}
    return completer.future;
  }

  // Görüntüyü getirme işlemi
  Image? getImage(String imageUrl) {
    // Önbellekte varsa doğrudan önbellekten al,
    if (loadedImages[imageUrl] != null) {
      return loadedImages[imageUrl];
    } else {
      return Image.network(imageUrl,
          width: 150,
          height: 150,
          cacheHeight: 150,
          cacheWidth: 150,
          filterQuality: FilterQuality.low,
          fit: BoxFit.cover);
    }
  }
}
