// basic_widgets/image_widget.dart

import 'package:flutter/material.dart';

class MyImageWidget extends StatelessWidget {
  const MyImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Add the "assets/" prefix to match pubspec.yaml
    return Image.asset("assets/logo_polinema.jpg");
  }
}