import 'package:flutter/material.dart';

double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getGoogleOrAppleIconWidth(BuildContext context) {
  return getScreenWidth(context) / 2.3;
}

double getDrawerWidth(BuildContext context) {
  return getScreenWidth(context) * 2 / 3;
}
