import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'check_information_page.dart';
import 'package:provider/provider.dart';
import '../storeditem.dart';

Future<void> recognizeText(BuildContext context, ImageSource source) async {
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(source: source);
  if (image == null) return;

  final InputImage inputImage = InputImage.fromFilePath(image.path);
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  final RecognizedText recognizedText =
      await textRecognizer.processImage(inputImage);

  final String _recognizedText = recognizedText.text;
  final XFile? _selectedImage = image;

  textRecognizer.close();

  if (_selectedImage != null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckInformationPage(
          recognizedText: _recognizedText,
          image: _selectedImage,
          onSubmit: (String name, String expiration, String location) {
            Provider.of<ItemProvider>(context, listen: false).addItem(
              name,
              expiration,
              location,
              _selectedImage,
            );
          },
        ),
      ),
    );
  }
}
