import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multiple_tapper/screen/provider/counter_provider.dart';
import 'package:multiple_tapper/utils/utils.dart';
import 'package:multiple_tapper/widgets/main_text_field.dart';

class CounterApp extends ConsumerStatefulWidget {
  const CounterApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CounterAppState();
}

class _CounterAppState extends ConsumerState<CounterApp> {
  bool isloaded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(counterProvider.notifier).init();
      setState(() {
        isloaded = true;
      });
    });
  }

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final counters = ref.watch(counterProvider);
    return isloaded
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                'Multi Counter',
                style: boldLato,
              ),
              centerTitle: true,
              elevation: 1,
            ),
            body: GridView.builder(
              itemCount: counters.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final Counter counter = counters[index];
                return Card(
                  shadowColor: Colors.black,
                  elevation: 5,
                  child: Stack(
                    children: [
                      InkWell(
                        splashColor: Colors.amber.shade300,
                        onTap: () {
                          ref
                              .read(counterProvider.notifier)
                              .increaseCount(index, counter.count);
                        },
                        onLongPress: () {
                          ref
                              .read(counterProvider.notifier)
                              .decreaseCount(index, counter.count);
                        },
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(counter.title, style: lato),
                                ),
                                const SizedBox(height: 10),
                                Text(counter.count.toString(),
                                    style: boldLato.copyWith(fontSize: 24),
                                    textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            resetSheet(context, counter.title, index),
                        icon: const FaIcon(FontAwesomeIcons.rotateRight),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () =>
                              removeSheet(context, counter.title, index),
                          icon: const FaIcon(
                            FontAwesomeIcons.xmark,
                            color: redColor,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    backgroundColor: Colors.amber,
                    onPressed: () => _helpBottomSheet(context),
                    tooltip: 'Help',
                    child: const FaIcon(FontAwesomeIcons.question),
                  ),
                  FloatingActionButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => _counterDialog(context),
                    ),
                    tooltip: 'Add Counter',
                    child: const FaIcon(FontAwesomeIcons.plus),
                  ),
                ],
              ),
            ),
          )
        : const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  Future<dynamic> resetSheet(BuildContext context, String title, int index) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        context: context,
        builder: (context) => Container(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Reset '$title' count",
                    style: lato.copyWith(fontSize: 20)),
                Row(
                  children: [
                    Flexible(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(40)),
                          onPressed: () {
                            ref
                                .read(counterProvider.notifier)
                                .resetCount(index);
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Yes',
                            style: lato.copyWith(
                                fontSize: 16, color: Colors.white),
                          )),
                    ),
                    const SizedBox(width: 20),
                    Flexible(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(40),
                              backgroundColor: Colors.white),
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'No',
                            style: lato.copyWith(
                                fontSize: 16, color: Colors.black),
                          )),
                    ),
                  ],
                )
              ],
            )));
  }

  Future<dynamic> removeSheet(BuildContext context, String title, int index) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        context: context,
        builder: (context) => Container(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Remove '$title' counter",
                    style: lato.copyWith(fontSize: 20)),
                Row(
                  children: [
                    Flexible(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(40),
                              backgroundColor: redColor),
                          onPressed: () {
                            ref
                                .read(counterProvider.notifier)
                                .removeCount(index);
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Yes',
                            style: lato.copyWith(
                                fontSize: 16, color: Colors.white),
                          )),
                    ),
                    const SizedBox(width: 20),
                    Flexible(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(40),
                              backgroundColor: Colors.white),
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'No',
                            style: lato.copyWith(
                                fontSize: 16, color: Colors.black),
                          )),
                    ),
                  ],
                )
              ],
            )));
  }

  Future<dynamic> _helpBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        context: context,
        builder: (context) => Container(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              color: Colors.amber.shade300,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('1. Add counter with "+" Button',
                    style: lato.copyWith(fontSize: 20)),
                Text('2. Tap tile, then the number increases',
                    style: lato.copyWith(fontSize: 20)),
                Text('3. Long press tile, then the number increases',
                    style: lato.copyWith(fontSize: 20)),
              ],
            )));
  }

  AlertDialog _counterDialog(BuildContext context) {
    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Counting content',
              style: lato,
            ),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
            )
          ],
        ),
        content: MainTextField(
          labelText: 'Add content',
          helperText: 'No duplication',
          focusNode: FocusNode(),
          autofocus: true,
          inputFormatters: [allAllow, LengthLimitingTextInputFormatter(20)],
          controller: controller,
        ),
        actions: [
          Consumer(
            builder: (context, ref, child) => ElevatedButton.icon(
                onPressed: () {
                  if (controller.text.trim().isEmpty) return;
                  ref
                      .read(counterProvider.notifier)
                      .addCounter(controller.text);
                  controller.clear();
                  Navigator.pop(context);
                },
                icon: const FaIcon(FontAwesomeIcons.clipboardCheck),
                label: Text('Add', style: lato)),
          )
        ]);
  }
}
