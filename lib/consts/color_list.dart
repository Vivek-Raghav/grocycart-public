import 'package:flutter/material.dart';

List<Color> colorList = const [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.purple,
  Colors.pink,
  Colors.teal,
  Colors.cyan,
  Colors.indigo,
  Colors.amber,
  Colors.brown,
  Colors.deepPurple,
  Colors.deepOrange,
  Colors.lime,
  Colors.lightGreen,
  Colors.lightBlue,
  Colors.grey,
  Colors.blueGrey,
  Colors.redAccent,
  Colors.blueAccent,
  Colors.greenAccent,
  Colors.yellowAccent,
  Colors.orangeAccent,
  Colors.purpleAccent,
  Colors.pinkAccent,
  Colors.tealAccent,
  Colors.cyanAccent,
  Colors.indigoAccent,
  Colors.amberAccent,
  Colors.deepPurpleAccent,
  Colors.deepOrangeAccent,
  Colors.limeAccent,
  Colors.lightGreenAccent,
  Colors.lightBlueAccent,
  Colors.transparent,
  Color(0xFFE57373),
  Color(0xFF81C784),
  Color(0xFFFFF176),
  Color(0xFFB39DDB),
  Color(0xFFFFB74D),
  Color(0xFF9E9E9E),
  Color(0xFF78909C),
  Color(0xFF455A64),
  Color(0xFF546E7A),
  Color(0xFF90A4AE),
  Color(0xFFDCE775),
  Color(0xFFBA68C8),
  Color(0xFF4FC3F7),
  Color(0xFF81D4FA),
  Color(0xFFFFD54F),
  Color(0xFFAED581),
  Color(0xFFE0E0E0),
  Color(0xFFCFD8DC),
  Color(0xFFB0BEC5),
  Color(0xFFEF9A9A),
  Color(0xFF64B5F6),
  Color(0xFF4DB6AC),
  Color(0xFF9575CD),
  Color(0xFFFF8A65),
  Color(0xFF9CCC65),
  Color(0xFF90CAF9),
  Color(0xFFFFD54F),
  Color(0xFFC5E1A5),
  Color(0xFFE57373),
  Color(0xFF81C784),
  Color(0xFFBBDEFB),
  Color(0xFFE1BEE7),
  Color(0xFFFFCCBC),
  Color(0xFFD7CCC8),
  Color(0xFFCFD8DC),
  Color(0xFFFFAB91),
  Color(0xFFB2DFDB),
  Color(0xFFC5CAE9),
  Color(0xFFA5D6A7),
  Color(0xFFB3E0FF),
  Color(0xFFF48FB1),
  Color(0xFFFFD180),
  Color(0xFFCE93D8),
  Color(0xFF80CBC4),
  Color(0xFFE0F7FA),
  Color(0xFFE6EE9C),
  Color(0xFFFFCDD2),
  Color(0xFFD1C4E9),
  Color(0xFFFFF59D),
  Color(0xFFC8E6C9),
  Color(0xFFA1887F),
  Color(0xFFBBDEFB),
  Color(0xFFFFCCBC),
  Color(0xFFC5CAE9),
  Color(0xFFB2DFDB),
  Color(0xFFE0F7FA),
  Color(0xFFD7CCC8),
  Color(0xFFCE93D8),
  Color(0xFFFFAB91),
  Color(0xFFF48FB1),
  Color(0xFFFFD180),
  Color(0xFF80CBC4),
  Color(0xFFE6EE9C),
  Color(0xFFA5D6A7),
  Color(0xFFB3E0FF),
  Color(0xFFC8E6C9),
  Color(0xFFA1887F),
];

LinearGradient greenGradient(BuildContext context) {
  return LinearGradient(
    colors: [
      Theme.of(context).primaryColor.withOpacity(0.9),
      Theme.of(context).primaryColor.withOpacity(0.8),
      Theme.of(context).primaryColor.withOpacity(0.6),
      Theme.of(context).primaryColor.withOpacity(0.4),
      Theme.of(context).primaryColor.withOpacity(0.2),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.bottomRight,
  );
}

LinearGradient greenButtonGradient(BuildContext context) {
  return LinearGradient(
    colors: [
      Theme.of(context).primaryColor,
      Theme.of(context).primaryColor,
      Theme.of(context).primaryColor.withOpacity(0.9),
      Theme.of(context).primaryColor.withOpacity(0.9),
      Theme.of(context).primaryColor.withOpacity(0.8),
      Theme.of(context).primaryColor.withOpacity(0.9),
      Theme.of(context).primaryColor.withOpacity(0.9),
      Theme.of(context).primaryColor.withOpacity(0.9),
      Theme.of(context).primaryColor.withOpacity(0.9),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.bottomRight,
  );
}
