import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import '../storeditem.dart';

class Refrigerator extends StatefulWidget {
  @override
  _RefrigeratorState createState() => _RefrigeratorState();
}

class _RefrigeratorState extends State<Refrigerator> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text(
            "냉장고",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          bottom: const TabBar(
            indicatorColor: Color(0xFF24AA5A),
            labelColor: Color(0xFF24AA5A),
            unselectedLabelColor: Colors.black38,
            tabs: [
              Tab(text: "전체보기"),
              Tab(text: "냉장고"),
              Tab(text: "냉동고"),
            ],
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  _buildAllItemsView(context),
                  _buildSingleLocationView(context, '냉장실'),
                  _buildSingleLocationView(context, '냉동실'),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _showAddItemDialog(context);
                  },
                  child: Text("추가하기"),
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                    primary: Color(0xFF24AA5A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllItemsView(BuildContext context) {
    final fridgeItems = Provider.of<ItemProvider>(context)
        .items
        .where((item) => item.location == '냉장실')
        .toList();
    final freezerItems = Provider.of<ItemProvider>(context)
        .items
        .where((item) => item.location == '냉동실')
        .toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildSection("냉장실", fridgeItems),
          _buildSection("냉동실", freezerItems),
        ],
      ),
    );
  }

  Widget _buildSingleLocationView(BuildContext context, String location) {
    final items = Provider.of<ItemProvider>(context)
        .items
        .where((item) => item.location == location)
        .toList();
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildSection(location, items),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Item> items) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          if (items.isEmpty)
            Center(
              child: IconButton(
                iconSize: 50.0,
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.grey,
                ),
                onPressed: () {
                  _showAddItemDialog(context);
                },
              ),
            )
          else
            GridView.builder(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Stack(
                  children: [
                    Image.file(
                      File(item.image.path),
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 8.0,
                      left: 8.0,
                      child: Text(
                        item.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          backgroundColor: Colors.black54,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8.0,
                      left: 8.0,
                      child: Text(
                        item.expiration,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          backgroundColor: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }

  void _showAddItemDialog(BuildContext context) {
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
                            _recognizeText(context, ImageSource.camera);
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
                            _recognizeText(context, ImageSource.gallery);
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

  Future<void> _recognizeText(BuildContext context, ImageSource source) async {
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
}

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
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the modal
                    },
                    child: Text('수정하기'),
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
            if (widget.image != null)
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
                child: Text('Submit'),
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
