import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multiple_tapper/screen/provider/counter_provider.dart';
import 'package:multiple_tapper/screen/widget/add_counter_alert.dart';
import 'package:multiple_tapper/utils/utils.dart';
import 'package:multiple_tapper/widgets/main_text_field.dart';

class CounterApp extends ConsumerWidget {
  CounterApp({super.key});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counters = ref.watch(counterProvider);
    return Scaffold(
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
          return Container(color: Colors.amber);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
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
                inputFormatters: [
                  allAllow,
                  LengthLimitingTextInputFormatter(20)
                ],
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
                        Navigator.pop(context);
                      },
                      icon: const FaIcon(FontAwesomeIcons.clipboardCheck),
                      label: Text('Add', style: lato)),
                )
              ]),
        ),
        tooltip: 'Add Counter',
        child: const Icon(Icons.add),
      ),
    );
  }
}
