void main() {
  var gifts = {'first': 'partridge', 'second': 'turtledoves', 'fifth': 1};

  var nobleGases = {2: 'helium', 10: 'neon', 18: 2};

  var mhs1 = Map<String, String>();
  mhs1['nama'] = 'Aryo Adi Putro';
  mhs1['nim'] = '2341720084';

  gifts['first'] = 'partridge';
  gifts['second'] = 'turtledoves';
  gifts['fifth'] = 'golden rings';
  gifts['nama'] = 'Aryo Adi Putro';
  gifts['nim'] = '2341720084';

  var mhs2 = Map<int, String>();
  mhs2[0] = 'Aryo Adi Putro';
  mhs2[1] = '2341720084';

  nobleGases[2] = 'helium';
  nobleGases[10] = 'neon';
  nobleGases[18] = 'argon';
  nobleGases[26] = 'Aryo Adi Putro';
  nobleGases[34] = '2341720084';

  print("gifts: ${gifts.toString()}");
  print("nobleGases: ${nobleGases.toString()}");
  print("mhs1: ${mhs1.toString()}");
  print("mhs2: ${mhs2.toString()}");
}
