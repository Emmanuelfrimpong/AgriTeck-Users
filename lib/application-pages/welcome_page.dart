
import 'package:agriteck_user/commonly-used-widget/shape-painter.dart';
import 'package:agriteck_user/styles/app-colors.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final String phoneNum;
  WelcomeScreen({this.phoneNum});
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: _height,
            width: _width,
            child: CustomPaint(
              painter: ShapePainter(), //background image-like design
            ),
          ),
          Container(
            height: _height,
            width: _width,
            child: SingleChildScrollView(
              child: Container(
                height: _height,
                width: _width,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.displayMedium,
                          children: [
                            TextSpan(
                                text: "Agri",
                                style: TextStyle(color: primaryLight)),
                            TextSpan(
                              text: "Teck",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyText1,
                          children: [
                            TextSpan(
                                text: "The Farmer's",
                                style: TextStyle(color: primaryLight)),
                            TextSpan(
                              text: " Best Friend,",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryDark),
                            ),
                            TextSpan(
                                text: " The Economy's",
                                style: TextStyle(color: primaryLight)),
                            TextSpan(
                              text: " Backbone",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryDark),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                     
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _raisedButton({Function onPressed, String text, double width}) {
    // ignore: deprecated_member_use
    return Container(
      width: width,
      // ignore: deprecated_member_use
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
       
      ),
    );
  }
}
