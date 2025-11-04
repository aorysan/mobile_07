# Pertemuan 11

## Aryo Adi Putro - 2341720084 || TI-3G

### Praktikum 1

#### Langkah 1

- Buatlah sebuah project flutter baru dengan nama books di folder src week-11 repository GitHub Anda.

- Kemudian Tambahkan dependensi http dengan mengetik perintah berikut di terminal.

``` dart
flutter pub add http
```

#### Langkah 2

- Jika berhasil install plugin, pastikan plugin http telah ada di file pubspec ini seperti berikut.

``` dart
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
```

#### Langkah 3

- Ketiklah kode seperti berikut ini.

``` dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Future Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const FuturePage(),
    );
  }
}

class FuturePage extends StatefulWidget {
  const FuturePage({super.key});

  @override
  State<FuturePage> createState() => _FuturePageState();
}

class _FuturePageState extends State<FuturePage> {
  String result = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back from the Future'),
      ),
      body: Center(
        child: Column(children: [
          const Spacer(),
          ElevatedButton(
            child: const Text('GO!'),
            onPressed: () {},
          ),
          const Spacer(),
          Text(result),
          const Spacer(),
          const CircularProgressIndicator(),
          const Spacer(),
        ]),
      ),
    );
  }
}
```

#### Langkah 4

- Tambahkan method ini ke dalam class _FuturePageState yang berguna untuk mengambil data dari API Google Books.

``` dart
  Future<Response> getData() async {
    const authority = 'www.googleapis.com';
    const path = '/books/v1/volumes/MbOkkqDEJbkC';
    Uri url = Uri.https(authority, path);

    return http.get(url);
  }
```

![alt text](image.png)

