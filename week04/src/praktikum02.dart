void main() {
  var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'};
  print(halogens);

  var names1 = <String>{};
  Set<String> names2 = {}; // This works, too.
  // var names3 = {}; // Creates a map, not a set.
  names1.add('Aryo Adi Putro');
  names2.addAll(['2341720084']);

  print(names1);
  print(names2);
  // print(names3);
}
