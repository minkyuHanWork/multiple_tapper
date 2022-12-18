import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multiple_tapper/utils/utils.dart';

class HelpFloatingButton extends StatelessWidget {
  const HelpFloatingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.amber,
      onPressed: () => _openBottomSheet(context),
      tooltip: 'Help',
      child: const FaIcon(FontAwesomeIcons.question),
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
}
