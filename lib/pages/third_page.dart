import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  void initState() {
    _loadEnv();
    super.initState();
  }

  Future<void> _loadEnv() async {
    await dotenv.load(fileName: '.env');
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
