import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CheckInformationPage extends StatefulWidget {
  final String recognizedText;
  final XFile image;
  final Function(String, String, String) onSubmit;

  CheckInformationPage({
    required this.recognizedText,
    required this.image,
    required this.onSubmit,
  });

  @override
  _CheckInformationPageState createState() => _CheckInformationPageState();
}

class _CheckInformationPageState extends State<CheckInformationPage> {
  late TextEditingController _controller1;
  late TextEditingController _controller2;
  String _dropdownValue = '냉장실';

  @override
  void initState() {
    super.initState();
    List<String> parts = widget.recognizedText.split(RegExp(r'[\s\n]+'));
    _controller1 =
        TextEditingController(text: parts.length > 0 ? parts[0] : '');
    _controller2 =
        TextEditingController(text: parts.length > 1 ? parts[1] : '');
  }

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
              Text('식재료명: ${_controller1.text}'),
              Text('소비기한: ${_controller2.text}'),
              Text('보관위치: $_dropdownValue'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the modal
                    },
                    child: Text(
                      '수정하기',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey[200], // submit 버튼 초록색
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      widget.onSubmit(
                        _controller1.text,
                        _controller2.text,
                        _dropdownValue,
                      );
                      Navigator.popUntil(
                        context,
                        (route) => route.isFirst,
                      ); // Return to the first page
                    },
                    child: Text('네, 맞아요'),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF24AA5A), // submit 버튼 초록색
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '식재료 추가',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '식재료명',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _controller1,
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green), // 밑줄 색깔 초록
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green), // 포커스된 밑줄 색깔 초록
                ),
                hintText: 'Enter your text here',
              ),
            ),
            SizedBox(height: 20),
            Text(
              '소비기한',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _controller2,
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green), // 밑줄 색깔 초록
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green), // 포커스된 밑줄 색깔 초록
                ),
                hintText: 'Enter your text here',
              ),
            ),
            SizedBox(height: 20),
            Text(
              '보관위치',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                value: _dropdownValue,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.transparent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    if (newValue != null) {
                      _dropdownValue = newValue;
                    }
                  });
                },
                items: <String>['냉장실', '냉동실']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            if (widget.image != false)
              Image.file(
                File(widget.image.path),
                height: 200,
              ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showModal(context);
                },
                child: Text('등록'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF24AA5A), // submit 버튼 초록색
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
