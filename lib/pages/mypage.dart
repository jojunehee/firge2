import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마이 페이지'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );},
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '소비기한 임박한 식재료가 5개 있어요',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFF7E0E0),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Row(
                children: [
                  Text(
                    '냉동실',
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  Text(
                    '2개',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFF7E0E0),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Row(
                children: [
                  Text(
                    '냉장실',
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  Text(
                    '3개',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFF7E0E0),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: Colors.grey,
                    height: 1,
                  );
                },
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      index == 0 ? '음식 취향 설정' : index == 1 ? '알림 설정' : '저장한 레시피',
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      switch (index) {
                        case 0:
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TasteSettingPage()),
                          );
                          break;
                        case 1:
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NotificationSettingPage()),
                          );
                          break;
                        case 2:
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SavedRecipePage()),
                          );
                          break;
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('알림'),
      ),
      body: Center(
        child: Text('알림 페이지'),
      ),
    );
  }
}

class TasteSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    '홍길동님의 음식 취향',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Add your edit logic here
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text('좋아하는 음식 종류'),
              trailing: Text(
                '한식, 양식',
                style: TextStyle(color: Color(0xFF24AA5A)),
              ),
            ),
            ListTile(
              title: Text('싫어하는 음식 종류'),
              trailing: Text(
                '중식',
                style: TextStyle(color: Color(0xFF24AA5A)),
              ),
            ),
            ListTile(
              title: Text('가장 좋아하는 음식'),
              trailing: Text(
                '김치찌개',
                style: TextStyle(color: Color(0xFF24AA5A)),
              ),
            ),
            ListTile(
              title: Text('가장 싫어하는 음식'),
              trailing: Text(
                '짜장면',
                style: TextStyle(color: Color(0xFF24AA5A)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationSettingPage extends StatefulWidget {
  @override
  _NotificationSettingPage createState() => _NotificationSettingPage();
}

class _NotificationSettingPage extends State<NotificationSettingPage> {
  bool _isChecked = false;
  bool _isChecked2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    '알림 설정',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text('소비기한 임박 알림'),
              trailing: Text(
                '3일 전',
                style: TextStyle(color: Color(0xFF24AA5A)),
              ),
            ),
            ListTile(
              title: Text('냉장고 현황 알림'),
              trailing: CupertinoSwitch(
                value: _isChecked,
                activeColor: CupertinoColors.activeGreen,
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked = value ?? false;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('레시피 추천 알림'),
              trailing: CupertinoSwitch(
                value: _isChecked2,
                activeColor: CupertinoColors.activeGreen,
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked2 = value ?? false;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SavedRecipePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    '저장한 레시피',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: AssetImage('assets/tomato.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ListTile(
                        title: Text('토마토 달걀 볶음',
                          style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                        onTap: () {
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
