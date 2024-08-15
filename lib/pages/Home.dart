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

  Future<void> speak(String text) async {
    await flutterTts.setLanguage(selectedLanguage ?? 'en-US');
    await flutterTts.setVolume(volume);
    await flutterTts.setPitch(pitch);
    await flutterTts.setSpeechRate(speechRate);
    await flutterTts.speak(text);
  }

  Future<void> save(String text) async {
    await flutterTts.setLanguage(selectedLanguage ?? 'en-US');
    await flutterTts.setVolume(volume);
    await flutterTts.setPitch(pitch);
    await flutterTts.setSpeechRate(speechRate);
    String timetemp = DateTime.now().millisecondsSinceEpoch.toString();

    // generate an audio and save to storage as a file
    await flutterTts.synthesizeToFile(
      text, "tts_audio_$timetemp.mp3"
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
                controller: textEditingController,
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
                          await speak(
                            textEditingController.text.isEmpty
                                ? 'Please enter some text to speak'
                                : textEditingController.text,
                          );
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
// DropdownButton for selecting language

              Padding(
                padding: const EdgeInsets.all(18.0),
                child: DropdownButton<String>(
                  dropdownColor: Colors.grey,
                  hint: Text(
                    'Select Language',
                  ),
                  value: selectedLanguage,
                  items: languageMap.keys
                      .map((String language) => DropdownMenuItem<String>(
                            value: language,
                            child: Text(language),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedLanguage = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Volume : ${volume.toStringAsFixed(1)}"),
              Slider(
                  activeColor: Colors.green,
                  min: 0.0,
                  max: 1.0,
                  value: volume,
                  onChanged: (value) {
                    setState(() {
                      volume = value;
                    });
                  }),
              SizedBox(
                height: 20,
              ),
              Text("Pitch : ${pitch.toStringAsFixed(1)}"),
              Slider(
                  activeColor: Colors.blue,
                  min: 0.5,
                  max: 1.0,
                  value: pitch,
                  onChanged: (value) {
                    setState(() {
                      pitch = value;
                    });
                  }),

              SizedBox(
                height: 20,
              ),
              Text("SpeechRate : ${speechRate.toStringAsFixed(1)}"),
              Slider(
                  activeColor: Colors.yellow,
                  min: 0.5,
                  max: 1.0,
                  value: speechRate,
                  onChanged: (value) {
                    setState(() {
                      speechRate = value;
                    });
                  }),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                   
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                    onPressed: () async {
                      await save(textEditingController.text);
                    },
                    child: Text("Save Audio")),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
