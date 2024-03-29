import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/memo.dart';

class HandleDB extends StatefulWidget {
  final Future<Database> db;
  HandleDB(this.db);

  @override
  State<HandleDB> createState() => _HandleDBState();
}

class _HandleDBState extends State<HandleDB> {
  late TextEditingController tcTitle;
  late TextEditingController tcContent;

  @override
  void initState() {
    super.initState();
    tcTitle = new TextEditingController();
    tcContent = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add database item'),
      ),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: tcTitle,
              decoration: InputDecoration(labelText: '먹은 음식'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: tcContent,
              decoration: InputDecoration(labelText: '음식 섭취량'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Memo memo = Memo(
                  title: tcTitle.value.text,
                  content: tcContent.value.text,
                  active: true);
              Navigator.of(context).pop(memo);
            },
            child: Text('저장'),
          )
        ],
      )),
    );
  }
}
