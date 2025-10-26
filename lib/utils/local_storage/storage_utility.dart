// import 'package:get_storage/get_storage.dart';

// class CLocalStorage {


//   late final GetStorage _storage;

//   static CLocalStorage? _instance;

//   CLocalStorage._internal();

//   factory CLocalStorage.instance() {
//     _instance ??=CLocalStorage._internal();
//      return _instance!;
//   }


//   static Future<void> init(String bucketName)async{
//     await GetStorage.init(bucketName);
//     _instance=CLocalStorage._internal();
//     _instance!._storage=GetStorage(bucketName);
//   }

//   // Generic method to save data
//   Future<void> saveData<T>(String key, T value) async {
//     await _storage.write(key, value);
//   }

//   // Generic method to read data
//   T? readData<T>(String key) {
//     return _storage.read<T>(key);
//   }

//   // Generic method to remove data
//   Future<void> removeData(String key) async {
//     await _storage.remove(key);
//   }

//   // Clear all data in storage
//   Future<void> clearAll() async {
//     await _storage.erase();
//   }
// }


import 'package:get_storage/get_storage.dart';

class CLocalStorage {
  GetStorage? _storage;
  String? _bucketName;

  static CLocalStorage? _instance;
  CLocalStorage._internal();

  factory CLocalStorage.instance() {
    _instance ??= CLocalStorage._internal();
    return _instance!;
  }

  /// Initialize once. Safe to call multiple times.
  static Future<void> init(String bucketName) async {
    // If already initialized with same bucket, return
    if (_instance != null && _instance!._storage != null && _instance!._bucketName == bucketName) {
      return;
    }

    await GetStorage.init(bucketName);
    _instance ??= CLocalStorage._internal();
    _instance!._bucketName = bucketName;
    _instance!._storage = GetStorage(bucketName);
  }

  /// Internal getter that throws a clear error if not initialized
  GetStorage get _safeStorage {
    if (_storage == null) {
      throw StateError(
        'CLocalStorage is not initialized. Call `await CLocalStorage.init(\'yourBucket\')` before using.'
      );
    }
    return _storage!;
  }

  Future<void> writeData<T>(String key, T value) async {
    await _safeStorage.write(key, value);
  }

  T? readData<T>(String key) {
    return _safeStorage.read<T>(key);
  }

  Future<void> removeData(String key) async {
    await _safeStorage.remove(key);
  }

  Future<void> clearAll() async {
    await _safeStorage.erase();
  }
}
