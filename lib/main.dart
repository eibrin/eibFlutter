import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:widget_master/pages/animation/bmi_ani.dart';
import 'package:widget_master/pages/animation/pong_like.dart';
import 'package:widget_master/pages/fourth_page.dart';
import 'package:widget_master/pages/listview_builder.dart';
import 'package:widget_master/pages/settings_page.dart';
import 'package:widget_master/pages/third_page.dart';
import 'pages/native.dart';
import 'parts/member_item.dart';
import 'pages/first_page.dart';
import 'pages/second_page.dart';
import 'pages/third_page.dart';

void main() async {
  // Avoid errors caused by flutter upgrade.
// Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  List<MemberItem> memberList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabBar ListView Setting'),
      ),
      body: TabBarView(
        children: <Widget>[
          FirstPage(list: memberList),
          //SecondPage(),
          //SettingsPage(),
          ListviewBuilder(),
          ThirdPage(),
          FourthPage(),
          BMIAni(),
          Native(),
        ],
        controller: controller,
      ),
      bottomNavigationBar: TabBar(
        tabs: const <Tab>[
          Tab(
            icon: Icon(Icons.looks_one, color: Colors.blue),
          ),
          Tab(
            icon: Icon(Icons.looks_two, color: Colors.purple),
          ),
          Tab(
            icon: Icon(Icons.looks_3, color: Colors.redAccent),
          ),
          Tab(
            icon: Icon(Icons.looks_4, color: Colors.greenAccent),
          ),
          Tab(
            icon: Icon(Icons.looks_5, color: Colors.greenAccent),
          ),
          Tab(
            icon: Icon(Icons.looks_6, color: Colors.greenAccent),
          ),
        ],
        controller: controller,
      ),
    );
  }

  // Tab contoller는 애니메이션을 사용하므로 dispose()를 써야 메모리 누수가 없다
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 6, vsync: this);

    memberList.add(MemberItem(path: 'lib/resources/img1.png', name: 'michael'));
    memberList.add(MemberItem(path: 'lib/resources/img2.png', name: 'jessi'));
    memberList.add(MemberItem(path: 'lib/resources/img3.png', name: 'queen'));
    memberList.add(MemberItem(path: 'lib/resources/img4.png', name: 'dalton'));
  }
}
