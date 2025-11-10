import 'package:flutter/material.dart';

class NavigationSecond extends StatefulWidget {
  const NavigationSecond({super.key});

  @override
  State<NavigationSecond> createState() => _NavigationSecondState();
}

class _NavigationSecondState extends State<NavigationSecond> {
  Color color = const Color.fromARGB(255, 4, 40, 77);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Navigation Aryok 2')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: const Text('Blue'),
              onPressed: () {
                color = const Color.fromARGB(255, 0, 170, 255);
                Navigator.pop(context, color);
              },
            ),
            ElevatedButton(
              child: const Text('Grey'),
              onPressed: () {
                color = const Color.fromARGB(255, 114, 114, 114);
                Navigator.pop(context, color);
              },
            ),
            ElevatedButton(
              child: const Text('Black'),
              onPressed: () {
                color = const Color.fromARGB(255, 0, 0, 0);
                Navigator.pop(context, color);
              },
            ),
          ],
        ),
      ),
    );
  }
}
