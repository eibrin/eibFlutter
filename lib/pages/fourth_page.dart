import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/memo.dart';
import 'handle_db/handle_db.dart';

class FourthPage extends StatefulWidget {
  //DatabaseApp(this.db);
  const FourthPage({super.key});

  @override
  State<FourthPage> createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  late Future<Database> db;
  late Future<List<Memo>> memoList;
  Memo? memo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db = initDatabase();
    memoList = getMemos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database Example'),
      ),
      body: Center(
        child: FutureBuilder(
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return CircularProgressIndicator();
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.active:
                return CircularProgressIndicator();
              case ConnectionState.done:
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      Memo memo = snapshot.data![index];
                      print(memo);
                      return Card(
                        child: Column(
                          children: [
                            Text(memo.title!),
                            Text(memo.content!),
                            Text(memo.active.toString()),
                          ],
                        ),
                      );
                    },
                    itemCount: snapshot.data!.length,
                  );
                } else {
                  return Text('No data');
                }
            }
            return CircularProgressIndicator();
          },
          future: memoList,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //final todo = await Navigator.of(context).pushNamed('/add');
          memo = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => HandleDB(db)));
          _insertMemo(memo!);
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _insertMemo(Memo memo) async {
    final Database database = await db;
    database.insert('memos', memo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    setState(() {
      memoList = getMemos();
    });
  }

  Future<List<Memo>> getMemos() async {
    final Database database = await db;
    final List<Map<String, dynamic>> maps = await database.query('memos');

    print('maps of query(memos) $maps');

    return List.generate(maps.length, (i) {
      bool active =
          maps[i]['active'] == 1 ? true : false; //sqlite는 bool형에 대해서 0,1로 표시함
      return Memo(
          title: maps[i]['title'].toString(),
          content: maps[i]['content'].toString(),
          active: active,
          id: maps[i]['id']);
    });
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
