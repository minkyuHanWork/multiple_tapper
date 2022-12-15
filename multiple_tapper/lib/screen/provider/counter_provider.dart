import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterNotifier extends StateNotifier<List<String>> {
  CounterNotifier() : super(<String>[]);

  void addCounter(String title) {
    final newState = [...state, title];
    state = newState;
  }
}

final counterProvider = StateNotifierProvider<CounterNotifier, List<String>>(
    (ref) => CounterNotifier());
