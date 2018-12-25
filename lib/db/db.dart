import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wanandroid/model/hotword.dart';

class DbManager {
  DbManager._internal();

  static DbManager singleton = DbManager._internal();

  //获取路径
  Future<String> get _dbPath async {
    var directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "WanAndroid.db";
    return path;
  }

  //创建数据库
  Future<Database> get _localFile async {
    final path = await _dbPath;
    var db = openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE history (id INTEGER PRIMARY KEY, name TEXT)");
    });
    return db;
  }

  Future<Null> clear() async {
    final db = await _localFile;
    db.execute("delete from history");
  }

  //保存数据
  Future<int> save(String key) async {
    final db = await _localFile;
    return db.transaction((trx) {
      trx.rawInsert('INSERT INTO history(name)'
          ' VALUES("${key}")');
    });
  }

  Future<bool> hasSameData(String key) async {
    final db = await _localFile;
    List<Map> list = await db
        .rawQuery('SELECT * FROM history where name="$key"');
    print(list);
    return list.length != 0;
  }

  //获取数据
  Future<List<Map>> getHistory() async {
    final db = await _localFile;
    List<Map> list = await db.rawQuery('SELECT * FROM history ORDER BY id DESC');
    return list;
  }
}
