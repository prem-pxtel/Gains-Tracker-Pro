import 'package:flutter/material.dart';
import 'dart:math';

Color randColor() {
  int a = Random().nextInt(255);
  int r = Random().nextInt(255);
  int g = Random().nextInt(255);
  int b = Random().nextInt(255);
  Color randColor = Color.fromARGB(a, r, g, b);
  return randColor;
}

String randEmoji() {

  var emojiList = ['⚽', '🏀', '⚾', '🏏', '🏆', '🎧', '💃', '🥑', '♀️', '⚽', '🍎', '🏋️‍♂️', '🏈', '♂️,' '🚲', '⛷️', '🏃‍♂️', '🤺', '🥊', '🏀', '🏏', '🥇', '🧘‍♀️', '🏋️‍♀️', '🏃‍♀️', '⚾', '🚿', '🥋', '🏅', '🛹', '🏐', '🤼‍♂️', '🥗', '🧘‍♂️', '🛶', '🤸‍♀️', '🏂', '🛷', '🎾', '🤼', '⛳', '🏟️', '🤾', '🏒', '🏓', '🏄‍♂️', '🤸', '🥈', '🥌', '🤿', '⛸️', '🥏', '🏌️‍♀️', '🥎', '🥉', '🥅', '🤸‍♂️', '🚴‍♀️', '🏌️‍♂️', '🏊‍♂️', '🏸', '🎿', '🤼‍♀️', '🏄‍♀️', '🧗‍♀️', '🥍', '🏊‍♀️', '🚴‍♂️', '⛹️‍♂️', '🏉', '🧗‍♂️', '🤾‍♀️', '🎽', '🚵‍♂️', '⛹️‍♀️', '🤾‍♂️', '🚣‍♂️', '🚣‍♀️', '🤽', '🏑', '🤽‍♂️', '🚵‍♀️', '🤽‍♀️'];
  int emojiIndex = Random().nextInt(82);
  return emojiList.elementAt(emojiIndex);

}