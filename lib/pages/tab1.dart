import 'package:flutter/material.dart';

class Tab1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 20),
          SizedBox(
            height: 200,
            width: 450,
            child: Card(
              color: Colors.grey[300],
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Text(
                      '냉장',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xFF24AA5A),
                              width: 2,
                            ),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Color(0xFF24AA5A),
                            ),
                            onPressed: () {
                              _showAddItemDialog(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                            print("카메라 기능 실행");
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
                            print("갤러리 기능 실행");
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
}
