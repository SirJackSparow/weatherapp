import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';

class LocalService {
  Future<void> initHive() async {
    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
  }

  Future<Box> openBox(String name) async {
    return await Hive.openBox(name);
  }

  Future<void> putData(String boxName, String key, dynamic value) async {
    final box = await openBox(boxName);
    await box.put(key, value);
  }

  Future<dynamic> getData(String boxName, String key) async {
    final box = await openBox(boxName);
    return box.get(key);
  }

  Future<void> deleteData(String boxName, String key) async {
    final box = await openBox(boxName);
    await box.delete(key);
  }
}
