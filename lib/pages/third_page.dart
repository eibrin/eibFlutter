import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../models/nutrition.dart'; // json 데이터 이용시에 필요함

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  String result = '';
  String tempo = '';
  String REST_API_KEY = '';
  String REST_API_GO = '';
  late nutrition nt;
  List<String> items = [];

  @override
  void initState() {
    _loadEnv();
    super.initState();
  }

  Future<void> _loadEnv() async {
    await dotenv.load(fileName: '.env');
    REST_API_KEY = dotenv.env['API_KEY']!;
    REST_API_GO = dotenv.env['API_KEY_GO']!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Http process'),
      ),
      body: Column(
        children: [
          SizedBox(
            // listview와 column이 겹칠때 에러남 해결:  (1) shrinkWrap: true, (2) SizedBox (3) Expanded
            height: MediaQuery.of(context).size.height / 2,
            child: ListView(
              children: [
                ...items.map((item) {
                  return Text(item);
                }).toList(),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                getFood('햄버거');
              },
              child: Icon(Icons.face_rounded))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var url = Uri.https(
              'www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});
          var response = await http.get(url);
          if (response.statusCode == 200) {
            var jsonResponse =
                convert.jsonDecode(response.body) as Map<String, dynamic>;
            var itemCount = jsonResponse['totalItems'];
            tempo = 'Number of books about http: $itemCount.';
          } else {
            tempo = 'Request failed with status: ${response.statusCode}.';
          }
          setState(() {
            result = tempo; //response.body;
          });
        },
        child: Icon(Icons.file_download),
      ),
    );
  }

  Future<String> getFood(String query) async {
    //var url = //Uri.https(
    var url = Uri.parse(
        'https://apis.data.go.kr/1471000/FoodNtrIrdntInfoService1/getFoodNtrItdntList1?serviceKey=$REST_API_GO&desc_kor=$query&pageNo=1&numOfRows=5&type=json');
    //&bgn_year=2017&animal_plant=(유)돌코리아');
    http.Response res = await http.get(url);

    if (res.statusCode == 200) {
      setState(() {
        var dec = jsonDecode(res.body);
        nt = nutrition.fromJson(dec);
        print(nt.body!.items!.first.dESCKOR);
        print(nt.body!.items![1].dESCKOR);
        print(nt.body!.items!.length);
        if (nt.body!.items != null) {
          for (var i in nt.body!.items!) {
            items.add(i.dESCKOR!);
          }
        }
      });
      return "Successful";
    } else {
      print("error while comm");
      return "failure";
    }
  }

  Future<String> getJSON() async {
    var url =
        Uri.https('dapi.kakao.com', '/v3/search/book?target=title&query=doit');
    var response = await http
        .get(url, headers: {"Authorization": "KakaoAK $REST_API_KEY"});
    setState(() {
      result = response.body;
    });
    return "Successful";
  }
}
