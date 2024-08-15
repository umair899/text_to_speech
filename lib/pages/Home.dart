import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController _textEditingController = TextEditingController();
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
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> speak() async {
    await flutterTts.setLanguage(selectedLanguage ?? 'en-US');
    await flutterTts.setVolume(volume);
    await flutterTts.setPitch(pitch);
    await flutterTts.setSpeechRate(speechRate);
    String timetemp = DateTime.now().millisecondsSinceEpoch.toString();

    // generate an audio and save to storage as a file
    await flutterTts.synthesizeToFile(
      "text",
      'audio/$timetemp.mp3',
    );
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
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Text to Speech',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _textEditingController,
                maxLines: 5,
                decoration: InputDecoration(
                  focusColor: Colors.yellow,
                  hintText: "Enter the text to speak",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.white)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () async {
                          await speak();
                        },
                        icon: Icon(Icons.play_arrow),
                        iconSize: 50,
                        color: Colors.green,
                      ),
                      Text('Play'),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () async {
                          await stop();
                        },
                        icon: Icon(Icons.stop),
                        iconSize: 50,
                        color: Colors.red,
                      ),
                      Text('Stop'),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () async {
                          await pause();
                        },
                        icon: Icon(Icons.pause),
                        iconSize: 50,
                        color: Colors.blue,
                      ),
                      Text('Pause'),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  hint: Text('Select Language'),
                  value: selectedLanguage,
                  items: languages
                      .map((language) => DropdownMenuItem<String>(
                            child: Text(languageMap[language]!),
                            value: language,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedLanguage = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
