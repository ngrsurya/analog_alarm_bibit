import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SizeConfig {
  static double screenWidth;
  static double screenHeight;
  static double _blockSizeWidth = 0;
  static double _blockSizeHeight = 0;

  static double textMultiplier;
  static double imageSizeMultiplier;
  static double heightMultiplier;
  static double widthMultiplier;

  static bool isPotrait = true;
  static bool isMobilePotrait = false;

  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      screenWidth = constraints.maxWidth;
      screenHeight = constraints.maxHeight;
      isPotrait = true;
      if (screenWidth < 450) {
        isMobilePotrait = true;
      }
    } else {
      screenWidth = constraints.maxHeight;
      screenHeight = constraints.maxWidth;
      isPotrait = false;
      isMobilePotrait = false;
    }
    _blockSizeWidth = screenWidth / 100;
    _blockSizeHeight = screenHeight / 100;

    textMultiplier = _blockSizeHeight;
    imageSizeMultiplier = _blockSizeWidth;
    heightMultiplier = _blockSizeHeight;
    widthMultiplier = _blockSizeWidth;
  }
}
