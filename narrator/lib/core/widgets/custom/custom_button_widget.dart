  import 'package:flutter/material.dart';

Column buildButtonColumn(
      Color color, Color splashColor, IconData icon, String label,   Function()? onPressed) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              icon: Icon(icon), color: color, splashColor: splashColor, onPressed:onPressed ),
          Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: Text(label,
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: color)))
        ]);
  }