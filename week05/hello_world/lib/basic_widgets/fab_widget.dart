import 'package:flutter/material.dart';

class FabWidget extends StatelessWidget {
  const FabWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // fab_widget.dart (Corrected)
    // Just return the FloatingActionButton.
    return FloatingActionButton(
      onPressed: () {
        // Add your onPressed code here!
        print("FabWidget Tapped!");
      },
      child: const Icon(Icons.thumb_up),
      backgroundColor: Colors.pink,
    );
  }
}
