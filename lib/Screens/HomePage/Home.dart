import 'package:agriteck_user/Screens/HomePage/CurePlant.dart';
import 'package:agriteck_user/Screens/HomePage/TipsSection.dart';
import 'package:agriteck_user/Screens/HomePage/WeatherWidget.dart';
import 'package:flutter/material.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({Key key}) : super(key: key);

  @override
  State<HomeMain> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeMain> {
  @override
  Widget build(BuildContext context) {
    return  CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: <Widget>[
         TipsOfTheDay(),
        CureYourPlant(),
         WeatherSection(),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
          ),
        )
      ],
    );
  }
}
