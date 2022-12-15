import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multiple_tapper/screen/add_counter.dart';
import 'package:multiple_tapper/storage/storage_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(textTheme),
      ),
      home: CounterApp(),
    );
  }
}

class Counter extends ConsumerStatefulWidget {
  const Counter({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CounterState();
}

class _CounterState extends ConsumerState<Counter> {
  bool isloaded = false;
  late int _counter;
  late int _counter2;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getStorage();
      setState(() {
        isloaded = true;
      });
    });
  }

  getStorage() async {
    final x = await ref.read(storageProvider).readAll();
    print(x);
    _counter = int.parse(x['counter']);
    _counter2 = int.parse(x['counter2']);
  }

  void _incrementCounter() {
    ref.read(storageProvider).write('counter', _counter.toString());
    setState(() {
      _counter++;
    });
  }

  void _incrementCounter2() {
    ref.read(storageProvider).write('counter2', _counter2.toString());
    setState(() {
      _counter2++;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counting'),
        centerTitle: true,
      ),
      body: isloaded
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '$_counter2',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: _incrementCounter2,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
