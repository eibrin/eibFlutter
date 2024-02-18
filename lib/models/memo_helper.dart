import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'memo.dart';

class MemoHelper {
  static final _databaseName = "memo.db";
  static final _version = 1;
  static final _tableName = 'memo5';

  static final columnId = 'id';
  static final columnTitle = 'title';
  static final columnContent = 'content';
  static final columnActive = 'active';
  List<Memo>? memoList;

  //late Memo? _memo;
  // only have a single app-wide reference to the database
  static late Database _db;
  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await openDB();
    return _db;
  }

  MemoHelper({this.memoList}) {
    openDB();
    getList();
  }

  // make this a singleton class
  MemoHelper._privateConstructor();
  static final MemoHelper instance = MemoHelper._privateConstructor();
  //factory MemoHelper() { return instance;}

  Future<Database> openDB() async {
    // 그냥 db 널체크만 하면 안된다. 계속 사용중이면 모를까 테스트때 계속 잘못된 db까지 포함해서 사용하기 위해서
    // db파일이 있다고 테이블이 있다는 것 까지 보장하지는 않음 -> no such table이 뜬다
    // 그렇다고 계속 테이블을 생성할 수는 없으니 create table if not exist로 연다
    //if (_db == null) {
    _db = await openDatabase(join(await getDatabasesPath(), _tableName),
        version: _version, onCreate: (db, version) {
      db.execute('''CREATE TABLE if not exists $_tableName (
                $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
                $columnTitle TEXT NOT NULL,
                $columnContent TEXT NOT NULL,
                $columnActive INTEGER)''');
    });
    // }
    return _db;
  }

  // check exists table
  // SELECT name FROM sqlite_master WHERE type='table' AND name='{table_name}';
  /*If you're using SQLite version 3.3+ you can easily create a table with:
  create table if not exists TableName (col1 typ1, ..., colN typN)
  In the same way, you can remove a table only if it exists by using:
  drop table if exists TableName*/

  // this opens the database (and creates it if it doesn't exist)
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return _db = (await openDatabase(path,
        version: _version, onCreate: (db, version) {}));
  }

  Future testDB() async {
    _db = await openDB();
    await _db.execute("INSERT INTO $_tableName VALUES (null,'ab', 'cd', 1)");
    await _db
        .execute("INSERT INTO $_tableName VALUES (null,'테스트', '테스트다냥', 1)");
    //int id = await db.insert('memo', _memo!.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    var imsi = await _db.rawQuery('SELECT * FROM $_tableName');
    print('imsi $imsi');
    /*prepopulate a few rows (consider using a transaction)
    await db.rawInsert(
        'INSERT INTO $table ($columnTitle, $columnContent) VALUES("Bob", 23)');
    await db.rawInsert(
        'INSERT INTO $table ($columnTitle, $columnContent) VALUES("Mary", 32)');
    await db.rawInsert(
        'INSERT INTO $table ($columnTitle, $columnContent) VALUES("Susan", 12)');*/
  }

  Future<Memo?> getItem(int id) async {
    var res =
        await _db.rawQuery('SELECT * FROM $_tableName WHERE id = ?', [id]);
    var maps = await _db.query(_tableName, where: 'id=?', whereArgs: [id]);
    if (res.isNotEmpty) {
      var r = res.first as Memo;
      return Memo(
          id: r.id, title: r.title, content: r.content, active: r.active);
      /*return List.generate(maps.length, (i) {
        return Memo(maps[i]['id'], maps[i]['title'], maps[i]['content'], maps[i]['active']);
      });*/
    }
    return null;
  }

  void getList() async {
    final List<Map<String, dynamic>> maps = await _db.query(_tableName);
    print('결과 갯수: ${maps.length}');
    memoList = List.generate(maps.length, (i) {
      return Memo(
          id: maps[i]['id'],
          title: maps[i]['title'],
          content: maps[i]['content'],
          active: (maps[i]['active'] == 1) ? true : false);
    });
  }

  Future showData() async {
    Memo memo = Memo(id: null, title: '이것이다', content: 'test', active: true);
    int? listId = await insertDB(memo);
    print('memo id : $listId');
  }

  Future<int?> insertDB(Memo memo) async {
    //int id = await _db?.execute('INSERT INTO memo2 VALUES (${memo.title}, ${memo.content}, ${memo.active}');
    _initDatabase();
    print('db: $_db');
    int? id = await _db?.insert('memo3', memo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }
}
