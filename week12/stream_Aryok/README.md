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

#### Langkah 4: Tambah variabel colors
- Tambahkan variabel di dalam class `ColorStream` seperti berikut.

```dart
import 'package:flutter/material.dart';

class ColorStream {
  final List<Color> colors = [
    Colors.blueGrey,
    Colors.amber,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.teal,
  ];
}
```

##### Soal 2
- **Tambahkan 5 warna lainnya sesuai keinginan Anda pada variabel `colors` tersebut.**
- Telah ditambahkan 5 warna lainnya: `Colors.pink`, `Colors.indigo`, `Colors.orange`, `Colors.cyan`, `Colors.lime`

```dart
final List<Color> colors = [
  Colors.blueGrey,
  Colors.amber,
  Colors.deepPurple,
  Colors.lightBlue,
  Colors.teal,
  Colors.pink,
  Colors.indigo,
  Colors.orange,
  Colors.cyan,
  Colors.lime,
];
```

#### Langkah 5: Tambah method `getColors()`
- Di dalam `class ColorStream` ketik method seperti kode berikut. Perhatikan tanda bintang di akhir keyword `async*` (ini digunakan untuk melakukan `Stream` data)

```dart
Stream<Color> getColors() async* {
  
}
```

#### Langkah 6: Tambah perintah `yield*`
- Tambahkan kode berikut ini.

```dart
yield* Stream.periodic(
  const Duration(seconds: 1), (int t) {
    int index = t % colors.length;
    return colors[index];
});
```

##### Soal 3
- **Jelaskan fungsi keyword `yield*` pada kode tersebut!**
  
  Keyword `yield*` digunakan untuk mengalirkan (stream) seluruh nilai dari Stream lain ke dalam Stream saat ini. Dalam kasus ini, `yield*` mengalirkan semua event dari `Stream.periodic` ke dalam Stream yang dikembalikan oleh method `getColors()`.

- **Apa maksud isi perintah kode tersebut?**
  
  Kode tersebut membuat Stream yang mengirimkan warna secara periodik setiap 1 detik. `Stream.periodic` menghasilkan event setiap detik dengan nilai integer `t` yang increment. Nilai `t` kemudian digunakan untuk menentukan index warna dengan operasi modulo `t % colors.length`, sehingga warna akan berputar secara berulang dari list colors.

#### Langkah 7: Buka `main.dart`
- Ketik kode impor file ini pada file `main.dart`

```dart
import 'stream.dart';
```

#### Langkah 8: Tambah variabel
- Ketik dua properti ini di dalam `class _StreamHomePageState`

```dart
Color bgColor = Colors.blueGrey;
late ColorStream colorStream;
```

#### Langkah 9: Tambah method `changeColor()`
- Tetap di file main, Ketik kode seperti berikut

```dart
void changeColor() async {
  await for (var eventColor in colorStream.getColors()) {
    setState(() {
      bgColor = eventColor;
    });
  }
}
```

#### Langkah 10: Lakukan override `initState()`
- Ketik kode seperti berikut

```dart
@override
void initState() {
  super.initState();
  colorStream = ColorStream();
  changeColor();
}
```

#### Langkah 11: Ubah isi `Scaffold()`
- Sesuaikan kode seperti berikut.

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Stream - Aryok'),
    ),
    body: Container(
      decoration: BoxDecoration(color: bgColor),
    ),
  );
}
```

#### Langkah 12: Run
- Lakukan running pada aplikasi Flutter Anda, maka akan terlihat berubah warna background setiap detik.

##### Soal 4
- **Capture hasil praktikum Anda berupa GIF dan lampirkan di README.**

![alt text](gif.gif)

Aplikasi berhasil menampilkan perubahan warna background secara otomatis setiap 1 detik menggunakan Stream dengan metode `await for`.

#### Langkah 13: Ganti isi method `changeColor()`
- Anda boleh comment atau hapus kode sebelumnya, lalu ketik kode seperti berikut.

```dart
void changeColor() async {
  colorStream.getColors().listen((eventColor) {
    setState(() {
      bgColor = eventColor;
    });
  });
}
```

