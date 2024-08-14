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
    setState(() {});
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
    String timetamp = DateTime.now().millisecondsSinceEpoch.toString();

    // generate an audio and save to storage as a file
    // await flutterTts.synthesizeToFile(text , "tts_audio_$timetamp.mp3");
  }

  Future<void> stop() async {
    await flutterTts.stop();
  }

  // for Pause
  Future<void> pause() async {
    await flutterTts.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Text to Speech',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: textEditingController,
                maxLines: 5,
                decoration : InputDecoration(
                  focusColor: Colors.white,
                  hintText : "Enter the text to speak",
                  border :OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // to be continue
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
