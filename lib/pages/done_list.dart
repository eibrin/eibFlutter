import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../models/memo.dart';

class DoneList extends StatefulWidget {
  final Future<Database> database;
  const DoneList(this.database, {super.key});

  @override
  State<DoneList> createState() => _DoneListState();
}

class _DoneListState extends State<DoneList> {
  late Future<List<Memo>> doneList;

  @override
  void initState() {
    super.initState();
    doneList = getDoneList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('완료한 일')),
        body: Container(
          child: Center(
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
                          return ListTile(
                            title: Text(
                              memo.title!,
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Container(
                              child: Column(
                                children: [
                                  Text(memo.content!),
                                  Container(
                                    height: 1,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: snapshot.data?.length,
                      );
                    }
                }
                return Text('No data');
              },
              future: doneList,
            ),
          ),
        ));
  }

  Future<List<Memo>> getDoneList() async {
    final Database database = await widget.database;
    List<Map<String, dynamic>> maps = await database
        .rawQuery('select title, content, id from memos where active=1');

    return List.generate(maps.length, (i) {
      return Memo(
          title: maps[i]['title'].toString(),
          content: maps[i]['content'].toString(),
          active: maps[i]['active'],
          id: maps[i]['id']);
    });
  }
}
