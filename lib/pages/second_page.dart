import 'package:flutter/material.dart';
import '../parts/member_item.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});
  //final List<MemberItem> list;

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final nameController = TextEditingController();
  int _radio1 = 0;
  bool _registered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              keyboardType: TextInputType.text,
              maxLines: 1,
            ),
            Row(
              children: [
                Radio(
                    value: 0,
                    groupValue: _radio1,
                    onChanged: (value) => _radioChange(value!)),
                const Text('남'),
                Radio(
                    value: 1,
                    groupValue: _radio1,
                    onChanged: (value) => _radioChange(value!)),
                const Text('여'),
                Radio(
                    value: 2,
                    groupValue: _radio1,
                    onChanged: (value) => _radioChange(value!)),
                const Text('동물'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                    value: _registered,
                    onChanged: (check) {
                      setState(() {
                        _registered = check!;
                      });
                    }),
                Text(" : Registerd Member"),
              ],
            ),
            Container(
                // listview horizontal scroll -> 웹에서는 동작이 안되나 모바일에서는 잘 동작함
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Image.asset('lib/resources/img1.png', width: 100),
                    Image.asset('lib/resources/img2.png', width: 100),
                    Image.asset('lib/resources/img3.png', width: 100),
                    Image.asset('lib/resources/img4.png', width: 100),
                    Image.asset('lib/resources/img5.png', width: 100),
                    Image.asset('lib/resources/img6.png', width: 100),
                    Image.asset('lib/resources/img1.png', width: 100),
                    Image.asset('lib/resources/img2.png', width: 100),
                    Image.asset('lib/resources/img3.png', width: 100),
                  ],
                )),
          ],
        ),
      ),
    ));
  }

  _radioChange(int value) {
    setState(() {
      _radio1 = value;
    });
  }
}
