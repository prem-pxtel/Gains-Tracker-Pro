import 'dart:math';

String randemoji(){

  var emojilist = ['⚽', '🏀', '⚾', '🏏', '🏆', '🎧', '💃', '🥑', '♀️', '⚽', '🍎', '🏋️‍♂️', '🏈', '♂️,' '🚲', '⛷️', '🏃‍♂️', '🤺', '🥊', '🏀', '🏏', '🥇', '🧘‍♀️', '🏋️‍♀️', '🏃‍♀️', '⚾', '🚿', '🥋', '🏅', '🛹', '🏐', '🤼‍♂️', '🥗', '🧘‍♂️', '🛶', '🤸‍♀️', '🏂', '🛷', '🎾', '🤼', '⛳', '🏟️', '🤾', '🏒', '🏓', '🏄‍♂️', '🤸', '🥈', '🥌', '🤿', '⛸️', '🥏', '🏌️‍♀️', '🥎', '🥉', '🥅', '🤸‍♂️', '🚴‍♀️', '🏌️‍♂️', '🏊‍♂️', '🏸', '🎿', '🤼‍♀️', '🏄‍♀️', '🧗‍♀️', '🥍', '🏊‍♀️', '🚴‍♂️', '⛹️‍♂️', '🏉', '🧗‍♂️', '🤾‍♀️', '🎽', '🚵‍♂️', '⛹️‍♀️', '🤾‍♂️', '🚣‍♂️', '🚣‍♀️', '🤽', '🏑', '🤽‍♂️', '🚵‍♀️', '🤽‍♀️'];
  int emojiindex = Random().nextInt((82));
  return emojilist.elementAt(emojiindex);

}