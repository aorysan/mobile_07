void main() {
  String format = "Aryo Adi Putro - 2341720084";
  int i, j;
  for (i = 0; i < 202; i++) {
    for (j = 2; j <= i; j++) {
      if (i < 2) {
        break;
      } else if (i % j == 0 && i != j) {
        break;
      } else if (i == j) {
        print("$i adalah bilangan prima - $format");
      }
    }
  }
}
