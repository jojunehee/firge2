import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_item_dialog.dart';
import 'check_information_page.dart';
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
              Tab(text: "냉장실"),
              Tab(text: "냉동실"),
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
                    showAddItemDialog(context);
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
                  showAddItemDialog(context);
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
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckInformationPage(
                          recognizedText: item.name + ' ' + item.expiration,
                          image: item.image,
                          onSubmit: (String name, String expiration,
                              String location) {
                            setState(() {
                              item.name = name;
                              item.expiration = expiration;
                              item.location = location;
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: Stack(
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
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
