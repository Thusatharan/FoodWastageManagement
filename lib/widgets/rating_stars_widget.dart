import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final int rating;
  final double fontSize;
  RatingStars(this.rating, this.fontSize);

  @override
  Widget build(BuildContext context) {
    String stars = '';
    for (var i = 0; i < rating; i++) {
      stars += '⭐  ';
    }
    stars.trim();
    return Text(
      stars,
      style: TextStyle(
        fontSize: fontSize,
      ),
    );
  }
}
