import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);
  static const Color shammerColor = Color(0xFFBACDDB);
  static const Color select = Color(0xFFD7E1FE);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorBlue1 = Color(0xFF2BACD1);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);

}

class MyColors{
  static Color appPrimaryColor = HexColor("007e7a");
  static Color greenSnackBar = HexColor("4AC000");
  static Color orangeSnackBar = HexColor("EF9300");
  static Color bgform = HexColor("F7F8F9");
  static Color bgformborder = HexColor("E8ECF4");
  static Color redSnackBar = HexColor("E01A1A");
  static Color greenPinPut = HexColor("35C2C1");
  static Color redOpacity = HexColor("FF9191");
  static Color greenDiscount = HexColor("5DCB6A");
  static Color bluePrice = HexColor("2754C5");
  static Color grey = HexColor("9B9B9B");
  static Color greyOpacity = HexColor("CDD4D3");
  static Color redEmergencyMenu = HexColor("C93131");
  static Color redTimer = HexColor("F71A1A");
  static Color greySeeAll = HexColor("8391A1");
  static Color blackMenu = HexColor("1F2340");
  static Color greyPromo = HexColor("77838F");
  static Color greyReview = HexColor("878787");
  static Color blueOpacity = HexColor("D7E1FE");
  static Color redNotification = HexColor("FF5959");
  static Color listChatColor = HexColor("2754C51A");
  static Color greyButton = HexColor("8391A1");
  static Color greyLanguage = HexColor('3C3C3C45');
  static Color select = HexColor('D7E1FE');
  static Color slider = HexColor('1010101A');
  static Color slider2 = HexColor('F7F8F9');
  static Color tabbar = HexColor('1F232F');
  static Color card = HexColor('D7E1FE');
  static Color bg = HexColor('F7F8F9');
  static Color green = HexColor('5DCB6A');
  static Color blackText  = Color(0xFF302B38);
  static Color yellow     = Color(0xFFF2BA30);
  static Color softGrey   = Color(0xFFE9E9E9);
  static Color white      = Color(0xFFFFFFFF);

}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}