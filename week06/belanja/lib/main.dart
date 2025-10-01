import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:belanja/pages/home_page.dart';
import 'package:belanja/pages/item_page.dart';
import 'models/item.dart';

void main() {
  final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => HomePage()),
      GoRoute(
        path: '/item',
        builder: (context, state) => ItemPage(item: state.extra as Item),
      ),
    ],
  );

  runApp(
    MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      builder: (context, child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomAppBar(
            child: Container(
              height: 50,
              alignment: Alignment.center,
              child: const Text(
                'Aryo Adi Putro / 2341720084',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        );
      },
    ),
  );
}
