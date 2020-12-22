import 'package:flutter/material.dart';

class Food {
  final String id;
  final String name;
  final String donatorId;
  final String image;
  final String available;
  final String donator;
  final double donatorRating;
  final String location;

  const Food({
    @required this.id,
    @required this.name,
    @required this.donatorId,
    @required this.image,
    @required this.available,
    @required this.donator,
    this.donatorRating,
    @required this.location,
  });
}
