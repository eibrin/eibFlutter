import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert; // json 데이터 이용시에 필요함

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  String result = '';
  String tempo = '';
  String REST_API_KEY = '';

  @override
  void initState() {
    _loadEnv();
    super.initState();
  }

  Future<void> _loadEnv() async {
    await dotenv.load(fileName: '.env');
    REST_API_KEY = dotenv.env['API_KEY']!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Http process'),
      ),
      body: Container(
        child: Column(
          children: [
            Center(
              child: Text('$result'),
            ),
            ElevatedButton(
                onPressed: () async {
                  getJSON();
                },
                child: Icon(Icons.face_rounded))
          ],
        ),
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

  Future<String> getJSON() async {
    var url =
        Uri.https('dapi.kakao.com', '/v3/search/book?target=title&query=doit');
    var response = await http
        .get(url, headers: {"Authorization": "KakaoAK ${REST_API_KEY}"});
    setState(() {
      result = response.body;
    });
    return "Successful";
  }
}
