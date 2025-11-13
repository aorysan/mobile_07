# Pertemuan 12

## Aryo Adi Putro - 2341720084 || TI-3G

### Praktikum 1: Dart Streams

#### Langkah 1: Buat Project Baru
- Buatlah sebuah project flutter baru dengan nama **stream_aryok** (beri nama panggilan Anda) di folder **week-12/src/** repository GitHub Anda.

#### Langkah 2: Buka file `main.dart`
- Ketiklah kode seperti berikut ini.

```dart
import 'package:flutter/material.dart';
import 'stream.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream - Aryok',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const StreamHomePage(),
    );
  }
}

class StreamHomePage extends StatefulWidget {
  const StreamHomePage({super.key});

  @override
  State<StreamHomePage> createState() => _StreamHomePageState();
}

class _StreamHomePageState extends State<StreamHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream - Aryok'),
      ),
      body: Container(),
    );
  }
}
```

##### Soal 1
- **Tambahkan nama panggilan Anda pada `title` app sebagai identitas hasil pekerjaan Anda.**
- **Gantilah warna tema aplikasi sesuai kesukaan Anda.**
- Sudah ditambahkan nama panggilan "Aryok" pada title app dan mengganti tema menjadi `Colors.deepPurple`

![Langkah 2](docs/soal1.png)

#### Langkah 3: Buat file baru `stream.dart`
- Buat file baru di folder lib project Anda. Lalu isi dengan kode berikut.

```dart
class ColorStream {
  
}
```
