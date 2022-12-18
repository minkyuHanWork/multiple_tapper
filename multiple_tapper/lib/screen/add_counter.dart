import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multiple_tapper/screen/provider/counter_provider.dart';
import 'package:multiple_tapper/screen/widget/color_picker_widget.dart';
import 'package:multiple_tapper/screen/widget/help_floating_button.dart';
import 'package:multiple_tapper/screen/widget/remove_button.dart';
import 'package:multiple_tapper/screen/widget/reset_button.dart';
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
                      _mainContent(index, counter),
                      // 초기화 버튼
                      ResetButton(title: counter.title, index: index),
                      // 삭제 버튼
                      RemoveButton(title: counter.title, index: index),
                      // 색상 선택 버튼
                      ColorPickerWidget()
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
                  const HelpFloatingButton(),
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

  InkWell _mainContent(int index, Counter counter) {
    return InkWell(
      splashColor: Colors.amber.shade300,
      onTap: () {
        ref.read(counterProvider.notifier).increaseCount(index, counter.count);
      },
      onLongPress: () {
        ref.read(counterProvider.notifier).decreaseCount(index, counter.count);
      },
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
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
    );
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
          ),
        ]);
  }
}
