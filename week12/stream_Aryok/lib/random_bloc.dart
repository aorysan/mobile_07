import 'dart:async';
import 'dart:math';

class RandomNumberBloc {
  // StreamController untuk input events
  final _generateRandomController = StreamController<void>();
  // StreamController untuk output data
  final _randomNumberController = StreamController<int>();

  // Sink untuk input (memasukkan event)
  Sink<void> get generateRandom => _generateRandomController.sink;
  // Stream untuk output (mengeluarkan data)
  Stream<int> get randomNumber => _randomNumberController.stream;

  RandomNumberBloc() {
    _generateRandomController.stream.listen((_) {
      final random = Random().nextInt(10);
      _randomNumberController.sink.add(random);
    });
  }

  void dispose() {
    _generateRandomController.close();
    _randomNumberController.close();
  }
}
