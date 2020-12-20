import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:food_wastage_management/screens/auth_screens/auth_screen.dart';
import 'package:food_wastage_management/widgets/intro_item_widget.dart';

class IntroScreen extends StatefulWidget {
  static const routeName = '/intro_screen';
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  SwiperController _swiperController = SwiperController();
  int _currentIndex = 0;

  final List<String> imageUrl = [
    'assets/images/intro_1.png',
    'assets/images/intro_2.png',
    'assets/images/intro_3.png',
  ];

  final List<String> titles = [
    'Welcome',
    'Sad Truth',
    'Be a hero',
  ];

  final List<String> subtitles = [
    'welcome to the team of foodCycle.',
    'Total average of food wastage in the world 1.3 billion tonnes and Average death due to hunger 25000 per day.',
    'Take Responsibility to feed the world with your excess food.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Swiper(
            index: _currentIndex,
            onIndexChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            loop: false,
            controller: _swiperController,
            pagination: SwiperPagination(
              margin: const EdgeInsets.only(bottom: 20.0),
              builder: DotSwiperPaginationBuilder(
                color: Colors.blueAccent,
                activeSize: 17.0,
                size: 13.0,
              ),
            ),
            itemCount: 3,
            itemBuilder: (context, index) {
              return IntroItemWidget(
                title: titles[index],
                subtitle: subtitles[index],
                imageUrl: imageUrl[index],
              );
            },
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 5.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: FlatButton(
                child: Text(
                  'SKIP',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(AuthScreen.routeName);
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 9.0,
              right: 5.0,
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Icon(
                  _currentIndex == 2 ? Icons.check : Icons.arrow_forward,
                  size: 30.0,
                  color: Colors.blueGrey,
                ),
                onPressed: () {
                  if (_currentIndex != 2) {
                    _swiperController.next();
                  } else {
                    Navigator.of(context)
                        .pushReplacementNamed(AuthScreen.routeName);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
