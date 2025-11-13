# Ringkasan Implementasi Praktikum Stream

## Yang Telah Dikerjakan:

### 1. File stream.dart
Dibuat file `lib/stream.dart` yang berisi:
- Class `ColorStream` dengan 10 warna (5 warna awal + 5 warna tambahan)
- Method `getColors()` yang mengembalikan Stream warna setiap 1 detik
- Menggunakan `Stream.periodic` dan `yield*`

### 2. File main.dart
Diubah dari template default menjadi:
- Import `stream.dart`
- Widget `StreamHomePage` dengan state management
- Variabel `bgColor` dan `colorStream`
- Method `changeColor()` menggunakan `.listen()` (bukan await for)
- Override `initState()` untuk inisialisasi stream
- Container dengan background color yang berubah

### 3. README.md
Dibuat dokumentasi lengkap dengan format seperti contoh yang Anda berikan:
- Struktur per Praktikum dan Langkah
- Penjelasan setiap soal
- Code snippets
- Tabel perbandingan untuk Soal 5
- Kesimpulan

### 4. Folder docs
Dibuat folder `docs/` untuk menyimpan screenshot dan GIF

## Yang Perlu Dilakukan Selanjutnya:

1. **Run aplikasi** untuk memastikan berjalan dengan baik
2. **Ambil screenshot** untuk `docs/soal1.png` (tampilan awal dengan nama Aryok)
3. **Buat GIF** untuk `docs/soal4.gif` (animasi perubahan warna)
4. **Commit ke GitHub** dengan pesan sesuai soal

## Cara Membuat Screenshot dan GIF:

### Screenshot (soal1.png):
- Run aplikasi
- Tunggu tampilan muncul
- Screenshot tampilan aplikasi
- Simpan sebagai `docs/soal1.png`

### GIF (soal4.gif):
Gunakan salah satu tools:
- **Windows**: ScreenToGif (gratis)
- **Online**: ezgif.com
- **VS Code Extension**: Screen Recorder

## Perintah Git untuk Commit:

```bash
# Untuk Soal 1
git add .
git commit -m "W12: Jawaban Soal 1"

# Untuk Soal 2
git add .
git commit -m "W12: Jawaban Soal 2"

# Untuk Soal 3
git add .
git commit -m "W12: Jawaban Soal 3"

# Untuk Soal 4 (setelah menambahkan GIF)
git add .
git commit -m "W12: Jawaban Soal 4"

# Untuk Soal 5
git add .
git commit -m "W12: Jawaban Soal 5"
```

## Penjelasan Kode Penting:

### Stream.periodic
```dart
Stream.periodic(const Duration(seconds: 1), (int t) {
  int index = t % colors.length;
  return colors[index];
})
```
- Membuat stream yang emit nilai setiap 1 detik
- Parameter `t` adalah counter yang terus bertambah
- Modulo `%` membuat index berputar kembali ke 0 setelah mencapai panjang array

### yield*
- Meneruskan semua event dari stream lain
- Berbeda dengan `yield` yang hanya emit satu nilai

### listen vs await for
- **listen**: Non-blocking, cocok untuk infinite stream
- **await for**: Blocking, cocok untuk finite stream

## Tips:
- Pastikan emulator/device sudah running sebelum `flutter run`
- Gunakan `r` untuk hot reload saat testing
- Gunakan `R` untuk hot restart jika ada error
