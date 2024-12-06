library progressive_buttons;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressiveButton extends StatefulWidget {
  final String text;
  final Function onPressed;
  const ProgressiveButton({super.key, required this.text, required this.onPressed, });

  @override
  State<ProgressiveButton> createState() => _ProgressiveButtonState();
}

class _ProgressiveButtonState extends State<ProgressiveButton> {
  ValueNotifier<bool> buttonProcessing = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding: EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),

      ),
      onPressed: () async {
        if(buttonProcessing.value == true) return;

        buttonProcessing.value = true;
        await widget.onPressed();
        buttonProcessing.value = false;
      },
      child: ValueListenableBuilder(
        valueListenable: buttonProcessing,
        builder: (context, value, child) {
          return buttonProcessing.value == true?progressLoader(color: Colors.white):Text(widget.text, style: TextStyle(color: Colors.white, fontSize: 16.0),);
        },
      ),
    );
  }


  Widget progressLoader({required Color color}){
    return Container(
      height: 20.0,
      width: 20.0,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        strokeWidth: 2.0,
      ),
    );
  }
}

