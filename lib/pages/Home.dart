import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textEditingController = TextEditingController();
  Map<String, String> languageMap = {
    'English': 'en-US',
    'Hindi': 'hi-IN',
    'Spanish': 'es-ES',
    'French': 'fr-FR',
    'German': 'de-DE',
    'Italian': 'it-IT',
    'Japanese': 'ja-JP',
    'Korean': 'ko-KR',
    'Chinese': 'zh-CN',
    'Russian': 'ru-RU',
  };
  List<String> languages = [];
  String? selectedLanguage;
  double volume = 0.5;
  double pitch = 1.0;
  double speechRate = 0.5;

  initState() {
    super.initState();
    initTts();
  }

  Future<void> initTts() async {
    List<dynamic> availableLanguages = await flutterTts.getLanguages;
    languages = availableLanguages
        .where((language) => languageMap.keys.contains(language))
        .map((language) => languages as String)
        .toList();
    setState(() {
      selectedLanguage = languages[0];
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  Future<void> speak() async {
    await flutterTts.setLanguage(selectedLanguage ?? 'en-US');
    await flutterTts.setVolume(volume);
    await flutterTts.setPitch(pitch);
    await flutterTts.setSpeechRate(speechRate);
// generate a random name file
    String timetamp = DateTime.now().millisecondsSinceEpoch.toString();
// create a file save in your devics
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.indigoAccent,
    );
  }
}
