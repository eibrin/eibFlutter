import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  late DatabaseReference dbRef;
  late String id;

  //SettingsPage(this.dbRef, this.id);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool bPush = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설정하기'),
      ),
      body: Center(
          child: Column(
        children: [
          Row(
            children: [
              Text(
                "푸시 알림",
                style: TextStyle(fontSize: 20),
              ),
              Switch(
                value: bPush,
                onChanged: (value) {
                  setState(() {
                    bPush = value;
                  });
                  _setData(value);
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {
              //Navigator.of(context).pushNamedAndRemoveUntil(('/'), (Route<dynamic> route) => false)
            },
            child: Text(
              '로그 아웃',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {
              AlertDialog dialog = new AlertDialog(
                title: Text('아이디 삭제'),
                content: Text('아이디를 삭제하시겠습니까?'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      print(widget.id);
                      widget.dbRef.child('user').child(widget.id).remove();
                      // 네비게이터의 모든 스택을 지우고 홈으로 이동
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/', (Route<dynamic> route) => false);
                    },
                    child: Text('YES'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('NO'),
                  ),
                ],
              );
              showDialog(
                  context: context,
                  builder: (context) {
                    return dialog;
                  });
            },
            child: Text('회원 탈퇴', style: TextStyle(fontSize: 20)),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      )),
    );
  }

  void _setData(bool value) async {
    var key = "push";
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(key, value);
  }

  void _loadData() async {
    var key = "push";
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      var value = pref.getBool(key);
      if (value == null) {
        setState(() {
          bPush = true;
        });
      } else {
        setState(() {
          bPush = value;
        });
      }
    });
  }
}
