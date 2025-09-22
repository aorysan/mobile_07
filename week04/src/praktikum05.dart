void main() {
  var record = ('first', a: 2, b: true, 'last');
  print(record);

  var swap = tukar((10, 20));
  print(swap);

  (String, int) mahasiswa = ('Aryo Adi Putro', 2341720084);
  print(mahasiswa);

  var mahasiswa2 = ('first', a: "Aryo Adi Putro/2341720084", b: true, 'last');

  print(mahasiswa2.$1); // Prints 'first'
  print(mahasiswa2.a); // Prints 2
  print(mahasiswa2.b); // Prints true
  print(mahasiswa2.$2); // Prints 'last'
}

(int, int) tukar((int, int) record) {
  var (a, b) = record;
  return (b, a);
}
