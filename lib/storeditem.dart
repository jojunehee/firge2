import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Item {
  final String name;
  final String expiration;
  final String location;
  final XFile image;

  Item({
    required this.name,
    required this.expiration,
    required this.location,
    required this.image,
  });
}

class ItemProvider with ChangeNotifier {
  final List<Item> _items = [];

  List<Item> get items => _items;

  void addItem(String name, String expiration, String location, XFile image) {
    _items.add(Item(
      name: name,
      expiration: expiration,
      location: location,
      image: image,
    ));
    notifyListeners();
  }
}
