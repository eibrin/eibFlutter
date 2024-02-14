import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/memo.dart';
import 'done_list.dart';
import 'handle_db/handle_db.dart';

class FoodManage extends StatefulWidget {
  const FoodManage({super.key});

  @override
  State<FoodManage> createState() => _FoodManageState();
}

class _FoodManageState extends State<FoodManage> {
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
        actions: [
          ElevatedButton(
            onPressed: () async {
              await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DoneList(db)));
              setState(() {
                memoList = getMemos();
              });
            },
            child: Text(
              '완료한 일',
              style: TextStyle(color: Colors.redAccent),
            ),
          )
        ],
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
                      //print(memo);
                      /*return Card(
                        child: Column(
                          children: [
                            Text(memo.title!),
                            Text(memo.content!),
                            Text(memo.active.toString()),
                          ],
                        ),
                      );*/
                      return ListTile(
                        title: Text(
                          memo.title!,
                          style: TextStyle(fontSize: 20),
                        ),
                        subtitle: Container(
                          child: Column(
                            children: [
                              Text(memo.content!),
                              Text('체크: ${memo.active.toString()}'),
                              Container(
                                height: 1,
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ),
                        onLongPress: () async {
                          Memo result = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('${memo.id} : ${memo.title}'),
                                  content: Text("${memo.content}를 삭제하시겠습니까?"),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(memo);
                                        },
                                        child: Text('yes')),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(memo);
                                        },
                                        child: Text('no')),
                                  ],
                                );
                              });
                          if (result != null) _deleteMemo(result);
                        },
                        onTap: () async {
                          TextEditingController ctrl =
                              new TextEditingController(text: memo.content);
                          Memo res = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('${memo.id} : ${memo.title}'),
                                  content: TextField(
                                    controller: ctrl,
                                    keyboardType: TextInputType.text,
                                  ),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            memo.active == true
                                                ? memo.active = false
                                                : memo.active = true;
                                            memo.content = ctrl.value.text;
                                          });
                                          Navigator.of(context).pop(memo);
                                        },
                                        child: Text('예')),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('아니오')),
                                  ],
                                );
                              });
                          if (res != null) {
                            _updateMemo(res);
                          }
                        }, //onTap
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

  void _deleteMemo(Memo memo) async {
    final Database database = await db;
    await database.delete('memos', whereArgs: [memo.id], where: 'id=?');
    setState(() {
      memoList = getMemos();
    });
  }

  void _updateMemo(Memo memo) async {
    final Database database = await db;
    await database.update(
      'memos',
      memo.toMap(),
      where: 'id=?',
      whereArgs: [memo.id],
    );
    setState(() {
      memoList = getMemos();
    });
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
    print(await getDatabasesPath());
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
