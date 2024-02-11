import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Native extends StatefulWidget {
  const Native({super.key});

  @override
  State<Native> createState() => _NativeState();
}

class _NativeState extends State<Native> {
  static const platform =
      MethodChannel('com.flutter.dev/info'); //need services library
  static const platform2 = MethodChannel('com.flutter.dev/encrypto');
  String _deviceInfo = 'Unknown info';
  TextEditingController controller = new TextEditingController();
  String _changeText = 'Nothing';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('native api'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 10),
            Text(
              _changeText,
              style: TextStyle(fontSize: 16),
            ),
            ElevatedButton(
              onPressed: () {
                _sendData(controller.value.text);
              },
              child: Text('encrpt'),
            ),
            SizedBox(height: 10),
            Text(
              _deviceInfo,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getDeviceInfo();
        },
        child: Icon(Icons.get_app),
      ),
    );
  }

  // 안드로이드 기기와 통신하는 함수여서 비동기로 설정해야 함
  Future<void> _getDeviceInfo() async {
    String deviceInfo;
    try {
      final result = await platform.invokeMethod<String>('getDeviceInfo');
      deviceInfo = 'Device info : $result';
    } on PlatformException catch (e) {
      deviceInfo = 'Failed to get device info: ${e.message}';
    }
    setState(() {
      _deviceInfo = deviceInfo;
    });
  }

  Future<void> _sendData(String text) async {
    String enc;
    try {
      final String result = await platform2.invokeMethod('getEncrypto', text);
      enc = result;
    } on PlatformException catch (e) {
      enc = 'Failed to get encryped data : ${e.message}';
    }
    print(enc);
    setState(() {
      _changeText = enc;
    });
  }
}
