import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

import 'pages/refrigerator.dart';
import 'pages/recipe.dart';
import 'pages/mypage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
      // home: TextRecognitionPage(),
    );
  }
}

class TextRecognitionPage extends StatefulWidget {
  @override
  _TextRecognitionPageState createState() => _TextRecognitionPageState();
}

class _TextRecognitionPageState extends State<TextRecognitionPage> {
  final ImagePicker _picker = ImagePicker();
  String _recognizedText = 'Select an image to recognize text';
  XFile? _selectedImage;

  Future<void> _recognizeText(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image == null) return;

    final InputImage inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    setState(() {
      _recognizedText = recognizedText.text;
      _selectedImage = image;
    });

    textRecognizer.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Recognition Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => _recognizeText(ImageSource.gallery),
              child: Text('Pick Image from Gallery and Recognize Text'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _recognizeText(ImageSource.camera),
              child: Text('Take Photo and Recognize Text'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_selectedImage != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckInformationPage(
                        recognizedText: _recognizedText,
                        image: _selectedImage,
                      ),
                    ),
                  );
                }
              },
              child: Text('Check Information'),
            ),
            SizedBox(height: 20),
            Text(_recognizedText),
          ],
        ),
      ),
    );
  }
}

class CheckInformationPage extends StatelessWidget {
  final String recognizedText;
  final XFile? image;

  CheckInformationPage({required this.recognizedText, required this.image});

  @override
  Widget build(BuildContext context) {
    // Split the recognized text into three parts based on spaces or new lines.
    List<String> parts = recognizedText.split(RegExp(r'[\s\n]+'));

    String part1 = parts.length > 0 ? parts[0] : '';
    String part2 = parts.length > 1 ? parts[1] : '';
    String part3 = parts.length > 2 ? parts.sublist(2).join(' ') : '';

    final TextEditingController controller1 =
        TextEditingController(text: part1);
    final TextEditingController controller2 =
        TextEditingController(text: part2);
    final TextEditingController controller3 =
        TextEditingController(text: part3);

    void _showModal(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('인식된 정보가 맞나요?'),
                Text('잘 못 인식된 부분이 있다면 수정할 수 있어요!'),
                SizedBox(height: 10),
                Text('식재료명: ${controller1.text}'),
                Text('소비기한: ${controller2.text}'),
                Text('보관위치: ${controller3.text}'),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the modal
                      },
                      child: Text('아니오'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.popUntil(
                            context,
                            (route) =>
                                route.isFirst); // Return to the first page
                      },
                      child: Text('예'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Check Information Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('식재료명'),
            SizedBox(height: 10),
            TextField(
              controller: controller1,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Enter your text here',
              ),
            ),
            SizedBox(height: 20),
            Text('소비기한'),
            SizedBox(height: 10),
            TextField(
              controller: controller2,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Enter your text here',
              ),
            ),
            SizedBox(height: 20),
            Text('보관위치'),
            SizedBox(height: 10),
            TextField(
              controller: controller3,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Enter your text here',
              ),
            ),
            SizedBox(height: 20),
            if (image != null)
              Image.file(
                File(image!.path),
                height: 200,
              ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showModal(context);
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    Refrigerator(),
    Recipe(),
    MyPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('My App'),
      // ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.kitchen),
              label: '냉장고',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: '레시피',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '마이페이지',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFF24AA5A),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
