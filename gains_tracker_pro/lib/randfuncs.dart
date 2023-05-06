import 'package:flutter/material.dart';
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