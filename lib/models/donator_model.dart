import 'package:flutter/material.dart';

class Donator {
  final String id;
  final String name;
  final String location;
  final String mobile;
  final String url;

  const Donator({
    @required this.id,
    @required this.name,
    @required this.location,
    @required this.mobile,
    this.url,
  });
}
