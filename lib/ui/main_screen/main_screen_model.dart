import 'dart:math';
import 'package:flutter/material.dart';

class MainScreenModel extends ChangeNotifier {
  int _result = 0;
  String _imagePath = 'images/thatshowirolldice.png';
  String _quote = '';
  int _diceCount = 0;
  final List<int> _rolls = [];
  final List<String> _images = [];

  int _d2Count = 0;
  int _d4Count = 0;
  int _d6Count = 0;
  int _d8Count = 0;
  int _d12Count = 0;
  int _d20Count = 0;

  final List<String> _quotes = [
    'Будь внимательней, чтобы не попасть под колесо чьей-либо фортуны.',
    'Если человек не верит в удачу, у него небогатый жизненный опыт.',
    'Беда не приходит одна, но и удача тоже.',
    'Кого удача любит, тот глупеет вдруг.',
    'Неудачники верят в удачу, люди удачливые верят в себя.',
    'Для счастья нужен еще и случай.',
  ];

  int? get result => _result;
  int get diceCount => _diceCount;
  String get imagePath => _imagePath;
  String get qoute => _quote;
  List<int> get rolls => _rolls;
  List<String> get images => _images;

  int get d2Count => _d2Count;
  int get d4Count => _d4Count;
  int get d6Count => _d6Count;
  int get d8Count => _d8Count;
  int get d12Count => _d12Count;
  int get d20Count => _d20Count;

  void rollDice(int dice) {
    final roll = Random().nextInt(dice) + 1;
    _result += roll;
    _rolls.add(roll);
    final image = 'images/greyd$dice.png';
    _imagePath = image;
    _images.add(image);
    _diceCount += 1;

    if (_rolls.length > 10) {
      _rolls.removeAt(0);
      _images.removeAt(0);
    }

    switch (dice) {
      case 2:
        _d2Count += 1;
      case 4:
        _d4Count += 1;
      case 6:
        _d6Count += 1;
      case 8:
        _d8Count += 1;
      case 12:
        _d12Count += 1;
      case 20:
        _d20Count += 1;
    }
    showQuote();
    notifyListeners();
  }

  void showQuote() {
    final quote = Random().nextInt(_quotes.length);
    _quote = _quotes[quote];
    notifyListeners();
  }

  void reset() {
    _result = 0;
    _imagePath = 'images/thatshowirolldice.png';
    _quote = '';
    _diceCount = 0;
    _d2Count = 0;
    _d4Count = 0;
    _d6Count = 0;
    _d8Count = 0;
    _d12Count = 0;
    _d20Count = 0;
    _rolls.clear();
    _images.clear();

    notifyListeners();
  }

  void increment() {
    _result += 1;
    notifyListeners();
  }

  void decrement() {
    _result -= 1;
    notifyListeners();
  }

  // void rollDice(int dice) {
  //   switch (dice) {
  //     case 2:
  //       final roll = Random().nextInt(2) + 1;
  //       _result = roll;
  //       const imageName = 'images/d20.png';
  //       _imagePath = imageName;
  //     case 4:
  //       final roll = Random().nextInt(4) + 1;
  //       _result = roll;
  //       const imageName = 'images/d4.png';
  //       _imagePath = imageName;
  //     case 6:
  //       final roll = Random().nextInt(6) + 1;
  //       _result = roll;
  //       const imageName = 'images/d6.png';
  //       _imagePath = imageName;
  //     case 8:
  //       final roll = Random().nextInt(8) + 1;
  //       _result = roll;
  //       const imageName = 'images/d8.png';
  //       _imagePath = imageName;
  //     case 12:
  //       final roll = Random().nextInt(12) + 1;
  //       _result = roll;
  //       const imageName = 'images/d12.png';
  //       _imagePath = imageName;
  //     case 20:
  //       final roll = Random().nextInt(20) + 1;
  //       _result = roll;
  //       const imageName = 'images/d20.png';
  //       _imagePath = imageName;
  //   }
  //   notifyListeners();
  // }
}
