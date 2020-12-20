import 'package:flutter/material.dart';

class IntroItemWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;

  const IntroItemWidget({this.title, this.subtitle, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final _isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: _isPortrait ? 250.0 : 200.0,
              child: Image.asset(imageUrl),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: _isPortrait ? 35.0 : 30.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: _isPortrait ? 25.0 : 20.0,
                fontWeight: FontWeight.w300,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
