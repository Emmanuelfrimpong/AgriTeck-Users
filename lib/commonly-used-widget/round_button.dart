import 'package:agriteck_user/styles/app-colors.dart';
import 'package:agriteck_user/styles/app-styles.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color;
  final bool isLoading;
  final Icon icon;
  RoundedButton(
      {Key key,
      this.text,
      this.press,
        this.icon,
      this.color,
      this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextButton(
      style: TextButton.styleFrom(
        backgroundColor: primary,
      ),
      onPressed: press,
      child:  isLoading != null && isLoading
          ? Image.asset(
        'assets/images/spinner.gif',
        width: 19.0,
        height: 19.0,
      )
          : Text(
        text,
        style: Styles.buttonTextStyle,
      ),

    );
  }
}
