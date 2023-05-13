import 'package:flutter/material.dart';
import 'quotes.dart';
import 'dart:math';

Color randColor() {
  int colorvalue = Random().nextInt(175);
  int r = colorvalue + Random().nextInt(80);
  int g = colorvalue + Random().nextInt(80);
  int b = colorvalue + Random().nextInt(80);
  Color randColor = Color.fromARGB(100, r, g, b);
  return randColor;
}

String randEmoji() {
  var emojiList = ['⚽', '🏀', '⚾', '🏏', '🏆', '🎧', '💃', '🥑', '♀️', '⚽', '🍎', '🏋️‍♂️', '🏈', '♂️', '🚲', '⛷️', '🏃‍♂️', '🤺', '🥊', '🏀', '🏏', '🥇', '🧘‍♀️', '🏋️‍♀️', '🏃‍♀️', '⚾', '🚿', '🥋', '🏅', '🛹', '🏐', '🤼‍♂️', '🥗', '🧘‍♂️', '🛶', '🤸‍♀️', '🏂', '🛷', '🎾', '🤼', '⛳', '🏟️', '🤾', '🏒', '🏓', '🏄‍♂️', '🤸', '🥈', '🥌', '🤿', '⛸️', '🥏', '🏌️‍♀️', '🥎', '🥉', '🥅', '🤸‍♂️', '🚴‍♀️', '🏌️‍♂️', '🏊‍♂️', '🏸', '🎿', '🤼‍♀️', '🏄‍♀️', '🧗‍♀️', '🥍', '🏊‍♀️', '🚴‍♂️', '⛹️‍♂️', '🏉', '🧗‍♂️', '🤾‍♀️', '🎽', '🚵‍♂️', '⛹️‍♀️', '🤾‍♂️', '🚣‍♂️', '🚣‍♀️', '🤽', '🏑', '🤽‍♂️', '🚵‍♀️', '🤽‍♀️'];
  int emojiIndex = Random().nextInt((82));
  return emojiList.elementAt(emojiIndex);
}

// with API, return Quote
Map<String, String?> randQuote(/*List<Quote> quoteList*/) {
  final random = Random();
  var element = quoteList[random.nextInt(quoteList.length - 1)];
  return element;
}