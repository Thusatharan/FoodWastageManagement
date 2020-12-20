import 'package:flutter/material.dart';
import 'package:food_wastage_management/widgets/clipper_widgets/back_curve_clipper_one.dart';
import 'package:food_wastage_management/widgets/clipper_widgets/back_curve_clipper_two.dart';
import 'package:food_wastage_management/widgets/clipper_widgets/front_curve_clipper.dart';

class AuthClipWidget extends StatelessWidget {
  final isportrait;
  AuthClipWidget(this.isportrait);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: BackCurveClipperOne(),
          child: Container(
            height: isportrait ? MediaQuery.of(context).size.height * 0.35 : MediaQuery.of(context).size.height * 0.6,
            color: Colors.blue.shade50,
          ),
        ),
        ClipPath(
          clipper: BackCurveClipperTwo(),
          child: Container(
            height: isportrait ? MediaQuery.of(context).size.height * 0.34 : MediaQuery.of(context).size.height * 0.6,
            color: Colors.blue.shade100,
          ),
        ),
        ClipPath(
          clipper: FrontCurveClipper(),
          child: Container(
            height: isportrait ? MediaQuery.of(context).size.height * 0.33 : MediaQuery.of(context).size.height * 0.6,
            color: Colors.blue.shade300,
          ),
        ),
      ],
    );
  }
}
