import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class loadingCupertino extends StatelessWidget {
  const loadingCupertino({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // loading_cupertino.dart (Corrected)
    // Just return the Column with its children.
    return Column(
      children: <Widget>[
        CupertinoButton(child: const Text("Contoh button"), onPressed: () {}),
        const CupertinoActivityIndicator(),
        const SizedBox(height: 20), // Added for better spacing
      ],
    );
  }
}
