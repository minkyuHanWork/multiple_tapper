import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multiple_tapper/screen/provider/counter_provider.dart';
import 'package:multiple_tapper/utils/utils.dart';

class ResetButton extends StatelessWidget {
  const ResetButton({
    Key? key,
    required this.title,
    required this.index,
  }) : super(key: key);

  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _openBottomSheet(context),
      icon: const FaIcon(FontAwesomeIcons.rotateRight),
    );
  }

  Future<dynamic> _openBottomSheet(BuildContext context) {
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
                      child: Consumer(
                        builder: (context, ref, child) => ElevatedButton(
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
}
