import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_tapper/storage/storage.dart';

class Counter {
  final String title;
  final int count;

  const Counter({
    required this.title,
    required this.count,
  });

  Counter copy({String? title, int? count}) =>
      Counter(title: title ?? this.title, count: count ?? this.count);
}

class CounterNotifier extends StateNotifier<List<Counter>> {
  CounterNotifier(this.ref) : super([]);

  final Ref ref;

  Future<bool> init() async {
    final encodedtitles = await ref.read(storageProvider).read('counterTitle');
    if (encodedtitles == null) return true;
    final titles = jsonDecode(encodedtitles);
    final counts = <int>[];
    for (int i = 0; i < titles.length; i++) {
      final count = await ref.read(storageProvider).read(titles[i]);
      counts.add(int.parse(count!));
    }
    final List<Counter> newState = [];
    for (int i = 0; i < titles.length; i++) {
      newState.add(Counter(title: titles[i], count: counts[i]));
    }
    state = newState;
    return true;
  }

  void storeCounterInStorage(String key, int value) {
    ref.read(storageProvider).write(key, value.toString());
  }

  void storeKeyValueInStorage() {
    final List<String> counterTitles =
        state.map((counter) => counter.title).toList();
    ref.watch(storageProvider).write('counterTitle', jsonEncode(counterTitles));
  }

  void addCounter(String title) {
    for (int i = 0; i < state.length; i++) {
      if (state[i].title == title) return;
    }
    final newState = [...state, Counter(title: title, count: 0)];
    state = newState;
    storeCounterInStorage(title, 0);
    storeKeyValueInStorage();
  }

  void increaseCount(int index, count) {
    final newState = [...state];
    final newCount = state[index].count + 1;
    final newCounter = state[index].copy(count: newCount);
    newState[index] = newCounter;
    state = newState;

    storeCounterInStorage(newCounter.title, newCounter.count);
  }

  void decreaseCount(int index, count) {
    final newState = [...state];
    final newCount = state[index].count - 1;
    final newCounter = state[index].copy(count: newCount);
    newState[index] = newCounter;
    state = newState;
    storeCounterInStorage(newCounter.title, newCounter.count);
  }

  void resetCount(int index) {
    final newState = [...state];
    final newCounter = state[index].copy(count: 0);
    newState[index] = newCounter;
    state = newState;

    storeCounterInStorage(newCounter.title, 0);
  }

  void removeCount(int index) {
    final newState = [...state];
    final deletedConter = newState.removeAt(index);
    state = newState;

    ref.read(storageProvider).delete(deletedConter.title);
    storeKeyValueInStorage();
  }
}

final counterProvider = StateNotifierProvider<CounterNotifier, List<Counter>>(
    (ref) => CounterNotifier(ref));
