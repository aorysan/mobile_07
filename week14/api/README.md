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

**Screenshot hasil:**

![alt text](gif1.gif)

WireMock hanya mengembalikan response statis yang sudah dikonfigurasi, tanpa benar-benar menyimpan data ke database. Ini berbeda dengan backend API yang real.

**Cara Memverifikasi POST Berhasil:**

1. **Cek Request Logs di WireMock:**
   - Login ke [WireMock Cloud](https://app.wiremock.cloud/)
   - Buka Mock API Anda
   - Klik tab **"Requests"** atau **"Request Logs"**
   - Lihat request POST yang masuk dengan body data yang dikirim

2. **Cek Debug Console:**
   - Print statement: `print('POST Response: ${r.body}')`
   - Lihat output: `{"message": "The pizza was posted"}`
   - Ini membuktikan request berhasil dikirim dan response diterima

3. **Response di UI:**
   - Text hijau muncul di atas form
   - Menampilkan message dari server

**Catatan:**
- GET akan selalu return data statis yang sama (data awal dari stub)
- POST/PUT hanya mensimulasikan operasi, tidak mengubah data di stub GET
- Untuk data persistent, gunakan backend API yang real (Node.js, Laravel, dll)

---

### Praktikum 3: Memperbarui Data di Web Service (PUT)

Praktikum ini bertujuan untuk mempelajari cara memperbarui data yang sudah ada di web service menggunakan HTTP PUT method. PUT digunakan untuk mengupdate data yang sudah tersimpan di server.

#### Langkah 1: Setup Stub PUT di Wire Mock

Membuat stub baru untuk endpoint PUT di Wire Mock Cloud:

**Konfigurasi:**
- Name: `Put Pizza`
- Verb: `PUT`
- Address: `/pizza`
- Status: `200` (OK)
- Body Type: `JSON`
- Body Response: `{"message": "Pizza was updated"}`

**Catatan:** PUT menggunakan endpoint yang sama dengan POST (`/pizza`), yang membedakan hanya HTTP verb-nya.

#### Langkah 2: Tambahkan method putPizza di HttpHelper

Menambahkan method `putPizza()` di class `HttpHelper` untuk melakukan PUT request.

**Link kode:** [lib/httphelper.dart - putPizza](https://github.com/aorysan/mobile_07/blob/main/week14/api/lib/httphelper.dart#L31-L41)

**Penjelasan method putPizza():**
```dart
Future<String> putPizza(Pizza pizza) async {
  const putPath = '/pizza';
  String put = json.encode(pizza.toJson());
  Uri url = Uri.https(authority, putPath);
  http.Response r = await http.put(
    url,
    body: put,
    headers: {'Content-Type': 'application/json'},
  );
  return r.body;
}
```

**Perbedaan dengan POST:**
- Method: `http.put()` vs `http.post()`
- Status code: 200 (OK) vs 201 (Created)
- Tujuan: Update data existing vs Create data baru
- Idempotent: Ya (bisa dipanggil berulang dengan hasil sama)

#### Langkah 3: Modifikasi PizzaDetailScreen

Menambahkan parameter `pizza` dan `isNew` untuk mendukung mode CREATE dan UPDATE.

**Link kode:** [lib/pizza_detail.dart - constructor](https://github.com/aorysan/mobile_07/blob/main/week14/api/lib/pizza_detail.dart#L5-L13)

**Perubahan:**
```dart
class PizzaDetailScreen extends StatefulWidget {
  final Pizza pizza;      // Pizza object untuk edit mode
  final bool isNew;       // Flag: true = POST, false = PUT
  
  const PizzaDetailScreen({
    super.key,
    required this.pizza,
    required this.isNew,
  });
}
```

**Kegunaan parameter:**
- `pizza`: Object yang akan diedit (kosong jika create new)
- `isNew`: Menentukan menggunakan POST atau PUT

#### Langkah 4: Override initState untuk Populate Form

Menambahkan logic untuk populate TextField saat edit mode.

**Link kode:** [lib/pizza_detail.dart - initState](https://github.com/aorysan/mobile_07/blob/main/week14/api/lib/pizza_detail.dart#L22-L32)

**Penjelasan:**
```dart
@override
void initState() {
  if (!widget.isNew) {
    // Populate fields dengan data existing
    txtId.text = widget.pizza.id.toString();
    txtName.text = widget.pizza.pizzaName ?? '';
    txtDescription.text = widget.pizza.description ?? '';
    txtPrice.text = widget.pizza.price.toString();
    txtImageUrl.text = widget.pizza.imageUrl ?? '';
  }
  super.initState();
}
```

**Alur:**
- Jika `isNew = false` (edit mode), isi form dengan data existing
- Jika `isNew = true` (create mode), form tetap kosong
- Menggunakan null-coalescing (`??`) untuk safety

#### Langkah 5: Modifikasi method savePizza

Mengubah `postPizza()` menjadi `savePizza()` yang support POST dan PUT.

**Link kode:** [lib/pizza_detail.dart - savePizza](https://github.com/aorysan/mobile_07/blob/main/week14/api/lib/pizza_detail.dart#L41-L56)

**Penjelasan:**
```dart
Future savePizza() async {
  HttpHelper helper = HttpHelper();
  Pizza pizza = Pizza();
  // Ambil data dari form
  pizza.id = int.tryParse(txtId.text);
  pizza.pizzaName = txtName.text;
  pizza.description = txtDescription.text;
  pizza.price = double.tryParse(txtPrice.text);
  pizza.imageUrl = txtImageUrl.text;
  
  // Ternary: pilih POST atau PUT
  final result = await (widget.isNew
      ? helper.postPizza(pizza)
      : helper.putPizza(pizza));
  
  setState(() {
    operationResult = result;
  });
}
```

**Conditional logic:**
- `widget.isNew = true` → call `postPizza()`
- `widget.isNew = false` → call `putPizza()`
- Single method untuk handle both operations

#### Langkah 6: Update Button Text

Mengubah text button sesuai mode operasi.

**Link kode:** [lib/pizza_detail.dart - button](https://github.com/aorysan/mobile_07/blob/main/week14/api/lib/pizza_detail.dart#L115-L120)

**Perubahan:**
```dart
ElevatedButton(
  child: Text(widget.isNew ? 'Add Pizza' : 'Update Pizza'),
  onPressed: () {
    savePizza();
  },
)
```

**UX improvement:**
- Create mode: "Add Pizza"
- Edit mode: "Update Pizza"
- Memberikan clarity ke user tentang action yang dilakukan

#### Langkah 7: Tambahkan onTap di ListTile

Menambahkan handler untuk tap pada list item untuk masuk ke edit mode.

**Link kode:** [lib/main.dart - onTap](https://github.com/aorysan/mobile_07/blob/main/week14/api/lib/main.dart#L101-L111)

**Penjelasan:**
```dart
return ListTile(
  title: Text(snapshot.data![position].pizzaName ?? 'Unnamed Pizza'),
  subtitle: Text(
    '${snapshot.data![position].description} - € ${snapshot.data![position].price.toString()}',
  ),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PizzaDetailScreen(
          pizza: snapshot.data![position],  // Pass pizza object
          isNew: false,                     // Edit mode
        ),
      ),
    );
  },
);
```

**Behavior:**
- User tap pizza item → Navigate ke detail screen
- Form ter-populate dengan data pizza yang dipilih
- Button menampilkan "Update Pizza"

#### Langkah 8: Update FloatingActionButton

Mengupdate FAB untuk pass parameter yang diperlukan.

**Link kode:** [lib/main.dart - FAB](https://github.com/aorysan/mobile_07/blob/main/week14/api/lib/main.dart#L118-L130)

**Penjelasan:**
```dart
floatingActionButton: FloatingActionButton(
  child: const Icon(Icons.add),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PizzaDetailScreen(
          pizza: Pizza(),    // Empty pizza object
          isNew: true,       // Create mode
        ),
      ),
    );
  },
)
```

**Behavior:**
- User tap FAB (+) → Navigate ke detail screen
- Form kosong untuk input data baru
- Button menampilkan "Add Pizza"

#### Langkah 9: Run dan Test

Menjalankan aplikasi dan testing PUT functionality.

##### Soal 3

![alt text](gif1.gif)

**Penjelasan:**
- Tap pada salah satu pizza dari list
- Form ter-populate dengan data existing
- Edit field yang diinginkan (contoh: nama menjadi "Aryo Adi Putro - 2341720084")
- Tekan "Update Pizza"
- Response "Pizza was updated" muncul

**Cara Memverifikasi PUT Berhasil di WireMock:**

1. **Cek Request Logs:**
   - Login ke [WireMock Cloud](https://app.wiremock.cloud/)
   - Buka Mock API Anda
   - Klik tab **"Requests"** atau **"Request Logs"**
   - Cari request dengan method **PUT** ke endpoint `/pizza`
   - Klik request untuk melihat detail:
     - Request Body: Data yang dikirim dari form
     - Response: `{"message": "Pizza was updated"}`
     - Timestamp: Waktu request diterima

2. **Screenshot Request Logs:**
   
   ![WireMock Request Logs](screenshots/wiremock_logs.png)
   
   Contoh informasi yang terlihat:
   ```json
   Method: PUT
   Path: /pizza
   Body: {
     "id": 1,
     "pizzaName": "Aryo Adi Putro - 2341720084",
     "description": "Pizza with tomato...",
     "price": 8.75,
     "imageUrl": "images/margherita.png"
   }
   Response: {"message": "Pizza was updated"}
   Status: 200
   ```

3. **Verifikasi di Debug Console:**
   - Output: `PUT Response: {"message": "Pizza was updated"}`
   - Membuktikan request PUT berhasil

**⚠️ Catatan Penting: Mengapa Data di ListView Tidak Berubah?**

**WireMock adalah Mock API (simulasi) yang TIDAK menyimpan data secara persistent.**

- WireMock hanya mengembalikan response statis yang sudah dikonfigurasi
- GET stub tetap return data awal yang sama
- POST/PUT hanya mensimulasikan operasi tanpa mengubah data di stub GET
- Ini adalah **behavior yang normal** untuk mock API

**Untuk melihat perubahan data yang persistent:**
- Gunakan backend API yang real (Node.js + MongoDB, Laravel + MySQL, dll)
- Atau gunakan mock service dengan storage seperti JSON Server

**Cara Membuktikan POST/PUT Berhasil:**
1. ✅ Response message muncul di UI (`"Pizza was updated"`)
2. ✅ Debug console menampilkan response
3. ✅ Request logs di WireMock menunjukkan request masuk dengan body yang benar

---

### Praktikum 4: Menghapus Data dari Web Service (DELETE)

Praktikum ini bertujuan untuk mempelajari cara menghapus data dari web service menggunakan HTTP DELETE method. DELETE digunakan untuk menghapus data yang sudah tersimpan di server. Implementasi menggunakan Dismissible widget untuk swipe to delete.

#### Langkah 1: Setup Stub DELETE di Wire Mock

Membuat stub baru untuk endpoint DELETE di Wire Mock Cloud:

**Konfigurasi:**
- Name: `Delete Pizza`
- Verb: `DELETE`
- Address: `/pizza`
- Status: `200` (OK)
- Body Type: `JSON`
- Body Response: `{"message": "Pizza was deleted"}`

#### Langkah 2: Tambahkan method deletePizza di HttpHelper

Menambahkan method `deletePizza()` di class `HttpHelper` untuk melakukan DELETE request.

**Link kode:** [lib/httphelper.dart - deletePizza](https://github.com/aorysan/mobile_07/blob/main/week14/api/lib/httphelper.dart#L44-L52)

**Penjelasan method deletePizza():**
```dart
Future<String> deletePizza(int id) async {
  const deletePath = '/pizza';
  Uri url = Uri.https(authority, deletePath);
  http.Response r = await http.delete(url);
  print('DELETE Response: ${r.body}'); // Debug
  return r.body;
}
```

**Detail implementasi:**
- Parameter: `int id` untuk identifikasi pizza yang akan dihapus
- Method: `http.delete()` untuk DELETE request
- Tidak memerlukan body (berbeda dengan POST/PUT)
- Tidak memerlukan header Content-Type karena tidak ada body
- Return: Response body dari server

#### Langkah 3: Implementasi Dismissible Widget

Membungkus `ListTile` dengan `Dismissible` widget untuk swipe to delete functionality.

**Link kode:** [lib/main.dart - Dismissible](https://github.com/aorysan/mobile_07/blob/main/week14/api/lib/main.dart#L60-L114)

**Penjelasan komponen Dismissible:**

1. **key: Key()**
   ```dart
   key: Key(snapshot.data![position].id.toString())
   ```
   - Unique key untuk setiap item
   - Menggunakan ID pizza sebagai identifier
   - Diperlukan untuk tracking widget yang di-dismiss

2. **onDismissed callback:**
   ```dart
   onDismissed: (direction) {
     HttpHelper helper = HttpHelper();
     // Remove dari local list (update UI)
     snapshot.data!.removeWhere(
       (element) => element.id == snapshot.data![position].id,
     );
     // Call DELETE API
     helper.deletePizza(snapshot.data![position].id!);
   }
   ```
   
   **Alur operasi:**
   - User swipe item → `onDismissed` triggered
   - Remove item dari list lokal (UI update instant)
   - Call `deletePizza()` ke API (background operation)
   - API response di-log ke debug console

3. **background:**
   ```dart
   background: Container(
     color: Colors.red,
     alignment: Alignment.centerRight,
     padding: const EdgeInsets.only(right: 20),
     child: const Icon(
       Icons.delete,
       color: Colors.white,
     ),
   )
   ```
   
   **UX enhancement:**
   - Background merah muncul saat swipe
   - Icon delete di sebelah kanan
   - Visual feedback yang jelas untuk destructive action

4. **child: ListTile**
   - Widget yang bisa di-swipe
   - Berisi tampilan pizza item
   - Tetap support `onTap` untuk edit

**Keuntungan Dismissible:**
- ✅ Gesture intuitif (swipe to delete)
- ✅ Animasi smooth
- ✅ Visual feedback dengan background
- ✅ Konsisten dengan Material Design pattern
- ✅ UX yang familiar untuk user mobile

#### Langkah 4: Run dan Test

Menjalankan aplikasi dan testing DELETE functionality.

##### Soal 4

**Screenshot hasil:**

![alt text](gif2.gif)

**Cara Memverifikasi DELETE Berhasil di WireMock:**

1. **Cek Request Logs:**
   - Login ke [WireMock Cloud](https://app.wiremock.cloud/)
   - Buka Mock API Anda
   - Klik tab **"Requests"** atau **"Request Logs"**
   - Cari request dengan method **DELETE** ke endpoint `/pizza`
   - Klik request untuk melihat detail:
     - Method: DELETE
     - Path: /pizza
     - Response: `{"message": "Pizza was deleted"}`
     - Status: 200

2. **Verifikasi di Debug Console:**
   - Output: `DELETE Response: {"message": "Pizza was deleted"}`
   - Membuktikan request DELETE berhasil

**⚠️ Catatan Penting tentang Mock API:**

Sama seperti POST dan PUT, **DELETE di WireMock hanya mensimulasikan operasi** tanpa benar-benar menghapus data dari stub GET.

- Item hilang dari UI karena `removeWhere()` pada list lokal
- Jika app di-restart, data akan kembali muncul (data di-fetch dari stub GET yang statis)
- Request logs di WireMock membuktikan request DELETE berhasil dikirim dan diterima
- Untuk data persistent yang benar-benar terhapus, gunakan backend API yang real

