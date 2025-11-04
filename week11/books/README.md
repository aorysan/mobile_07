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

#### Langkah 5

- Tambahkan kode pada onPressed di ElevatedButton seperti berikut.

``` dart
            ElevatedButton(child: const Text('GO!'), onPressed: () {
              setState(() {
                result = 'Loading...';
              });
              getData().then((value) {
                setState(() {
                  result = value.body.toString().substring(0, 450);
                  setState(() {});
                });
              }).catchError((error) {
                setState(() {
                  result = 'Error: $error';
                  setState(() {});
                });
              });
            }),
```

- Lakukan run aplikasi Flutter Anda. Anda akan melihat tampilan akhir seperti gambar berikut. Jika masih terdapat error, silakan diperbaiki hingga bisa running.

![alt text](image-1.png)

- Penjelasan

| Bagian kode                | Fungsi utama                                                                                              |
| -------------------------- | --------------------------------------------------------------------------------------------------------- |
| `substring(0, 450)`        | Membatasi teks hasil HTTP hanya 450 karakter pertama                                                      |
| `catchError((error){...})` | Menangani error dari proses asynchronous (`Future`) agar aplikasi tidak crash dan menampilkan pesan error |

### Praktikum 2

#### Langkah 1

- Tambahkan tiga method berisi kode seperti berikut di dalam class _FuturePageState.

``` dart
Future<int> returnOneAsync() async {
  await Future.delayed(const Duration(seconds: 3));
  return 1;
}

Future<int> returnTwoAsync() async {
  await Future.delayed(const Duration(seconds: 3));
  return 2;
}

Future<int> returnThreeAsync() async {
  await Future.delayed(const Duration(seconds: 3));
  return 3;
}
```

#### Langkah 2

- Lalu tambahkan lagi method ini di bawah ketiga method sebelumnya.

``` dart
  Future count () async {
    int total = 0;
    total = await returnOneAsync();
    total += await returnTwoAsync();
    total += await returnThreeAsync();

    setState(() {
      result = total.toString();
    });
  }
```

#### Langkah 3

- Lakukan comment kode sebelumnya, ubah isi kode onPressed() menjadi seperti berikut.

``` dart
onPressed: () {
    count();
```

#### Langkah 4

- Akhirnya, run atau tekan F5 jika aplikasi belum running. Maka Anda akan melihat seperti gambar berikut, hasil angka 6 akan tampil setelah delay 9 detik.

![alt text](image-2.png)

- Kode dari langkah 1 dan 2 diatas yaitu untuk menambah jumlah nilai dari total pada setiap delay 3 detik yang mana pada tiap delay memiliki nilai yang berbeda untuk ditambahkan pada total.

### Praktikum 3

#### Langkah 1

- Pastikan telah impor package async berikut.

``` dart
import 'package:async/async.dart';
```

#### Langkah 2

- Tambahkan variabel late dan method di class _FuturePageState seperti ini.

``` dart
late Completer completer;

Future getNumber() {
  completer = Completer<int>();
  calculate();
  return completer.future;
}

Future calculate() async {
  await Future.delayed(const Duration(seconds : 5));
  completer.complete(42);
}
```

#### Langkah 3

- Tambahkan kode berikut pada fungsi onPressed(). Kode sebelumnya bisa Anda comment.



``` dart
getNumber().then((value) {
    setState(() {
    result = value.toString();
    });
});
```

#### Langkah 4

- Terakhir, run atau tekan F5 untuk melihat hasilnya jika memang belum running. Bisa juga lakukan hot restart jika aplikasi sudah running. Maka hasilnya akan seperti gambar berikut ini. Setelah 5 detik, maka angka 42 akan tampil.

![alt text](image-3.png)

![alt text](<gif.gif>)

- Penjelasan

| Bagian                   | Fungsi                                            |
| ------------------------ | ------------------------------------------------- |
| `Completer<int>()`       | Membuat Future yang bisa diselesaikan manual      |
| `completer.future`       | Future yang akan dikembalikan dan bisa di-`await` |
| `completer.complete(42)` | Menandakan Future selesai dengan nilai 42         |
| `Future.delayed(...)`    | Menunda penyelesaian selama 5 detik               |

#### Langkah 5

- Gantilah isi code method calculate() seperti kode berikut, atau Anda dapat membuat calculate2()

``` dart
  calculate() async {
    try {
      await new Future.delayed(const Duration(seconds: 5));
      completer.complete(42);
    } catch (e) {
      completer.completeError(e);
    }
  }
```

#### Langkah 6

- Ganti menjadi kode seperti berikut.

``` dart
getNumber().then((value) {
  setState(() {
    result = value.toString();
  });
}).catchError((e) {
  result = 'An error occurred';
});
```

- Penjelasan

| Kode                         | Fungsi                                               |
| ---------------------------- | ---------------------------------------------------- |
| `.then((value){ ... })`      | Dijalankan saat Future selesai dengan sukses         |
| `.catchError((e){ ... })`    | Dijalankan saat Future gagal (ada error)             |
| `completer.complete(42)`     | Menyelesaikan Future dengan nilai 42                 |
| `completer.completeError(e)` | Menyelesaikan Future dengan status error             |
| `setState()`                 | Memperbarui tampilan UI Flutter setelah data berubah |
