import 'package:flutter/material.dart';

class Refrigerator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "냉장고",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
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
          ),
          body: Column(
            children: [
              Expanded(
                child: TabBarView(
                  children: [
                    Center(
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
                                  top: 10, // 위쪽 여백
                                  left: 10, // 왼쪽 여백
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
                                          border: Border.all(color: Color(0xFF24AA5A), width: 2), // 테두리를 초록색으로 설정
                                        ),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.add,
                                            color: Color(0xFF24AA5A), // 플러스 아이콘을 초록색으로 설정
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
                        SizedBox(height: 20),
                        SizedBox(
                          height: 200,
                          width: 450,
                          child: Card(
                            color: Colors.grey[300],
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 10, // 위쪽 여백
                                  left: 10, // 왼쪽 여백
                                  child: Text(
                                    '냉동',
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
                                          border: Border.all(color: Color(0xFF24AA5A), width: 2), // 테두리를 초록색으로 설정
                                        ),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.add,
                                            color: Color(0xFF24AA5A), // 플러스 아이콘을 초록색으로 설정
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
                    )
                    ),
                    Center(
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
                                  top: 10, // 위쪽 여백
                                  left: 10, // 왼쪽 여백
                                  child: Text(
                                    '냉동',
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
                                          border: Border.all(color: Color(0xFF24AA5A), width: 2), // 테두리를 초록색으로 설정
                                        ),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.add,
                                            color: Color(0xFF24AA5A), // 플러스 아이콘을 초록색으로 설정
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
                    )
                    ),
                    Center(
                      child: Column(
                      children: [
                        SizedBox(height: 20),
                        SizedBox(
                          height: 300,
                          width: 450,
                          child: Card(
                            color: Colors.grey[300],
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 10, // 위쪽 여백
                                  left: 10, // 왼쪽 여백
                                  child: Text(
                                    '냉동',
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
                                          border: Border.all(color: Color(0xFF24AA5A), width: 2), // 테두리를 초록색으로 설정
                                        ),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.add,
                                            color: Color(0xFF24AA5A), // 플러스 아이콘을 초록색으로 설정
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
                    )
                    ),
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
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
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
                        // 갤러리 기능 실행
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

void main() {
  runApp(MaterialApp(
    home: Refrigerator(),
  ));
}