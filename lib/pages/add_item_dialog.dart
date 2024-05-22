import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'text_recognition.dart';

void showAddItemDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        title: Center(
          child: Text(
            "추가할 방법을 선택해주세요.",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 24.0),
        content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: () {
                          recognizeText(context, ImageSource.camera);
                        },
                        elevation: 2.0,
                        fillColor: Colors.grey[200],
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                          size: 30.0,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "카메라",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: () {
                          recognizeText(context, ImageSource.gallery);
                        },
                        elevation: 2.0,
                        fillColor: Colors.grey[200],
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                        child: Icon(
                          Icons.photo_library,
                          color: Colors.black,
                          size: 30.0,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "갤러리",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      );
    },
  );
}
