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

---

### Praktikum 2: Mengirim Data ke Web Service (POST)

Praktikum ini bertujuan untuk mempelajari cara mengirim data ke web service menggunakan HTTP POST method. POST digunakan untuk menambahkan data baru ke server.

#### Langkah 1: Setup Stub POST di Wire Mock

Membuat stub baru untuk endpoint POST di Wire Mock Cloud:

**Konfigurasi:**
- Name: `Post Pizza`
- Verb: `POST`
- Address: `/pizza`
- Status: `201` (Created)
- Body Type: `JSON`
- Body Response: `{"message": "The pizza was posted"}`

#### Langkah 2: Modifikasi Model Pizza

Mengubah class Pizza menjadi mutable (nullable fields) agar bisa digunakan untuk form input.

**Link kode:** [lib/pizza.dart](https://github.com/aorysan/mobile_07/blob/main/week14/api/lib/pizza.dart#L1-L39)

**Perubahan:**
```dart
// Dari final (immutable) menjadi nullable (mutable)
int? id;
String? pizzaName;
String? description;
double? price;
String? imageUrl;
```

**Alasan perubahan:**
- Properties nullable memungkinkan pembuatan objek Pizza kosong
- Memudahkan assignment dari TextEditingController
- Cocok untuk form input yang belum terisi

#### Langkah 3: Tambahkan method postPizza di HttpHelper

Menambahkan method `postPizza()` di class `HttpHelper` untuk melakukan POST request.

**Link kode:** [lib/httphelper.dart](https://github.com/aorysan/mobile_07/blob/main/week14/api/lib/httphelper.dart#L18-L28)

**Penjelasan method postPizza():**
```dart
Future<String> postPizza(Pizza pizza) async {
  const postPath = '/pizza';
  String post = json.encode(pizza.toJson()); // Serialization
  Uri url = Uri.https(authority, postPath);
  http.Response r = await http.post(
    url,
    body: post,
    headers: {'Content-Type': 'application/json'},
  );
  return r.body;
}
```

**Detail implementasi:**
- `json.encode()`: Mengkonversi Map dari `toJson()` menjadi JSON string
- `http.post()`: Melakukan POST request dengan body JSON
- `headers`: Menambahkan Content-Type untuk memberitahu server bahwa data adalah JSON
- Return: Response body dari server (message success/error)

#### Langkah 4: Buat PizzaDetailScreen

Membuat file `pizza_detail.dart` yang berisi form untuk input data pizza baru.

**Link kode:** [lib/pizza_detail.dart](https://github.com/aorysan/mobile_07/blob/main/week14/api/lib/pizza_detail.dart#L1-L128)

**Komponen utama:**

1. **TextEditingController** (5 buah):
   - `txtId`: Input ID pizza
   - `txtName`: Input nama pizza
   - `txtDescription`: Input deskripsi
   - `txtPrice`: Input harga
   - `txtImageUrl`: Input URL gambar

2. **operationResult**:
   - String untuk menyimpan response dari server
   - Ditampilkan di atas form dengan background hijau

3. **dispose()**:
   - Override method untuk cleanup controllers
   - Penting untuk menghindari memory leaks

**Link kode:** [dispose() method](https://github.com/aorysan/mobile_07/blob/main/week14/api/lib/pizza_detail.dart#L20-L27)

#### Langkah 5: Implementasi UI Form

Membuat UI form dengan TextField untuk setiap property Pizza.

**Link kode:** [build() method](https://github.com/aorysan/mobile_07/blob/main/week14/api/lib/pizza_detail.dart#L42-L123)

**Struktur UI:**
- `Scaffold` dengan AppBar
- `SingleChildScrollView` untuk scrollable form
- `Column` berisi:
  - Text untuk menampilkan result
  - 5 TextField dengan decoration dan keyboardType yang sesuai
  - ElevatedButton untuk trigger POST

**Fitur TextField:**
- Border outline untuk visual yang jelas
- HintText sebagai placeholder
- KeyboardType sesuai tipe data (number, text)

#### Langkah 6: Implementasi method postPizza

Membuat method untuk mengambil data dari form dan mengirim ke server.

**Link kode:** [postPizza() method](https://github.com/aorysan/mobile_07/blob/main/week14/api/lib/pizza_detail.dart#L29-L40)

**Penjelasan:**
```dart
Future postPizza() async {
  HttpHelper helper = HttpHelper();
  Pizza pizza = Pizza(); // Buat objek kosong
  
  // Ambil data dari controllers
  pizza.id = int.tryParse(txtId.text);
  pizza.pizzaName = txtName.text;
  pizza.description = txtDescription.text;
  pizza.price = double.tryParse(txtPrice.text);
  pizza.imageUrl = txtImageUrl.text;
  
  // POST ke server
  String result = await helper.postPizza(pizza);
  
  // Update UI dengan response
  setState(() {
    operationResult = result;
  });
}
```

**Kegunaan tryParse:**
- `int.tryParse()`: Konversi string ke int, return null jika gagal
- `double.tryParse()`: Konversi string ke double, return null jika gagal
- Mencegah error jika user input invalid

#### Langkah 7: Tambahkan FloatingActionButton

Menambahkan FAB di main screen untuk navigasi ke form detail.

**Link kode:** [FloatingActionButton](https://github.com/aorysan/mobile_07/blob/main/week14/api/lib/main.dart#L68-L78)

**Penjelasan:**
```dart
floatingActionButton: FloatingActionButton(
  child: const Icon(Icons.add),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PizzaDetailScreen(),
      ),
    );
  },
),
```

**Navigator.push:**
- Menambahkan route baru ke navigation stack
- MaterialPageRoute: Transition animation default Material Design
- User bisa kembali dengan back button

#### Langkah 8: Run dan Test

Menjalankan aplikasi dan testing POST functionality.

##### Soal 2
![alt text](gif.gif)
