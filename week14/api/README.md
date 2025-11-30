# Pertemuan 14

## Aryo Adi Putro - 2341720084 || TI-3G

### Praktikum 1: Membuat layanan Mock API

Praktikum ini bertujuan untuk mempelajari cara menggunakan RESTful API dengan Flutter, membuat layanan mock API menggunakan Wire Mock Cloud, dan mengambil data dari layanan web.

#### Langkah 1: Daftar layanan Mock Lab

Mendaftar untuk layanan Mock Lab di [https://app.wiremock.cloud/](https://app.wiremock.cloud/) dan membuat stub baru dengan nama "Pizza List".

**Setup stub:**
- Name: `Pizza List`
- Verb: `GET`
- URL: `/pizzalist`
- Response Status: `200`
- Format: `JSON`
- Body: Data pizza dari [https://bit.ly/pizzalist](https://bit.ly/pizzalist)

#### Langkah 2: Tambahkan dependensi http

Menambahkan package `http` untuk melakukan request ke server.

**Link kode:** [pubspec.yaml](https://github.com/aorysan/mobile_07/blob/main/week14/api/pubspec.yaml#L36)

#### Langkah 3: Buat model Pizza

Membuat file `pizza.dart` yang berisi model data Pizza dengan method `fromJson()` untuk deserialization dan `toJson()` untuk serialization.

**Link kode:** [lib/pizza.dart](https://github.com/aorysan/mobile_07/blob/main/week14/api/lib/pizza.dart#L1-L38)

**Penjelasan:**
- **Constructor Pizza**: Menerima semua field yang required
- **fromJson()**: Factory constructor yang mengonversi Map dari JSON menjadi objek Pizza
- **toJson()**: Method yang mengonversi objek Pizza kembali menjadi Map untuk serialization

#### Langkah 4: Buat file httphelper.dart

Membuat file `httphelper.dart` yang berisi class `HttpHelper` dengan singleton pattern untuk melakukan HTTP request.

**Link kode:** [lib/httphelper.dart](https://github.com/aorysan/mobile_07/blob/main/week14/api/lib/httphelper.dart#L1-L32)

**Penjelasan Singleton Pattern:**
```dart
static final HttpHelper _httpHelper = HttpHelper._internal();
HttpHelper._internal();
factory HttpHelper() {
  return _httpHelper;
}
```

**Keuntungan Singleton Pattern:**
- Hanya membuat satu instance dari class `HttpHelper` di seluruh aplikasi
- Menghemat memory dan resource
- Memastikan konsistensi konfigurasi
- Menghindari pembuatan instance berulang kali

**Method getPizzaList():**
- Menggunakan `Uri.https()` untuk membuat URL
- Melakukan GET request menggunakan `http.get()`
- Mengecek status code apakah `HttpStatus.ok` (200)
- Mengkonversi JSON response menjadi List objek Pizza
- Return empty list jika request gagal

#### Langkah 5: Edit main.dart

Mengupdate `main.dart` untuk menggunakan `HttpHelper` dan menampilkan data pizza menggunakan `FutureBuilder`.

**Link kode:** [lib/main.dart](https://github.com/aorysan/mobile_07/blob/main/week14/api/lib/main.dart#L1-L60)

**Perubahan yang dilakukan:**

1. **Import dependencies:**
   - Import `httphelper.dart` dan `pizza.dart`

2. **Ubah title dan tema:**
   ```dart
   title: 'Pizza App - Aryok',
   theme: ThemeData(
     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
   ),
   ```

3. **Buat method callPizzas():**
   ```dart
   Future<List<Pizza>> callPizzas() async {
     HttpHelper helper = HttpHelper();
     List<Pizza> pizzas = await helper.getPizzaList();
     return pizzas;
   }
   ```

4. **Implementasi FutureBuilder di body:**
   - Memanggil `callPizzas()` sebagai future
   - Menampilkan error message jika `snapshot.hasError`
   - Menampilkan `CircularProgressIndicator` jika data belum tersedia
   - Membuat `ListView.builder` yang menampilkan setiap pizza dalam `ListTile`

**Penjelasan FutureBuilder:**

`FutureBuilder` adalah widget yang membangun UI berdasarkan snapshot terbaru dari interaksi dengan Future:

- **future**: Future yang akan di-await (dalam hal ini `callPizzas()`)
- **builder**: Function yang membangun widget berdasarkan snapshot
- **AsyncSnapshot**: Object yang berisi status dan data dari Future
  - `hasError`: Mengecek apakah ada error
  - `hasData`: Mengecek apakah data sudah tersedia
  - `data`: Data yang dikembalikan dari Future

**ListView.builder:**
- `itemCount`: Jumlah item yang akan ditampilkan
- `itemBuilder`: Function yang membangun setiap item
- Menampilkan nama pizza, deskripsi, dan harga dalam `ListTile`

#### Langkah 6: Run aplikasi

Menjalankan aplikasi dan melihat daftar pizza yang diambil dari Mock API.

##### Soal 1

![alt text](image.png)

