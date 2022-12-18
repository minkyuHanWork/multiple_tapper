import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_tapper/utils/font.dart';

List<Color> colors = [
  Colors.black87,
  Colors.white,
  Colors.amber,
  Colors.blue,
  Colors.blueGrey,
  Colors.brown,
  Colors.cyan,
  Colors.green,
  Colors.grey,
  Colors.indigo,
  Colors.lightBlue,
  Colors.lightGreen,
  Colors.lime,
  Colors.orange,
  Colors.pink,
  Colors.purple,
  Colors.red,
  Colors.teal,
  Colors.yellow,
  Colors.deepOrangeAccent
];

class ColorPickerWidget extends ConsumerStatefulWidget {
  const ColorPickerWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends ConsumerState<ColorPickerWidget> {
  Color pickerColor = Colors.black87;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: IconButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Pick Color',
              style: boldLato,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlockPicker(
                    pickerColor: pickerColor,
                    availableColors: colors,
                    onColorChanged: (color) => setState(() {
                          pickerColor = color;
                        })),
                TextButton(
                    onPressed: () {},
                    child: Text('SELECT', style: lato.copyWith(fontSize: 18)))
              ],
            ),
          ),
        ),
        icon: Material(
          borderRadius: BorderRadius.circular(100),
          elevation: 5,
          child: const Image(
            image: AssetImage('assets/color_picker.png'),
          ),
        ),
      ),
    );
  }
}
