import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AppCacheManager extends CacheManager with ImageCacheManager {
  static const String _key = '_camelImageCaches';

  static final AppCacheManager _instance = AppCacheManager._internal();

  factory AppCacheManager() => _instance;

  AppCacheManager._internal() : super(Config(_key, maxNrOfCacheObjects: 200));
}
