import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FourthPage extends StatefulWidget {
  late final Future<Database> db;
  //DatabaseApp(this.db);
  //const FourthPage({super.key});

  @override
  State<FourthPage> createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase();
    return Scaffold(
      appBar: AppBar(
        title: Text('DATA processing'),
      ),
      body: Text('aa'),
    );
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'memo.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE memos(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, active BOOL)",
        );
      },
      version: 1,
    );
  }
}

class DatabaseApp extends StatefulWidget {
  const DatabaseApp({super.key});

  @override
  State<DatabaseApp> createState() => _DatabaseAppState();
}

class _DatabaseAppState extends State<DatabaseApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database Example'),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final todo = await Navigator.of(context).pushNamed('/add');
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
