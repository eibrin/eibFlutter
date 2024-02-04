import 'package:flutter/material.dart';
import 'package:widget_master/parts/member_item.dart';

class FirstPage extends StatelessWidget {
  //const FirstPage({super.key});
  final List<MemberItem>? list;
  FirstPage({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ListView.builder(
            itemBuilder: (context, position) {
              return GestureDetector(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset(
                          list![position].path as String,
                          height: 200,
                          width: 200,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 20),
                        Text(list![position].name as String)
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  AlertDialog dialog = AlertDialog(
                    content: Text(
                      '이 회원의 이름은 ${list![position].name} 입니다.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  );
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => dialog);
                },
              );
            },
            itemCount: list?.length,
          ),
        ),
      ),
    );
  }
}
