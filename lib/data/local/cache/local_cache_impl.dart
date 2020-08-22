import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'local_cache.dart';

class LocalCacheImpl implements LocalCache {
  SharedPreferences sharedPreferences;
  LocalCacheImpl({this.sharedPreferences});
}
