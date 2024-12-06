library progressive_buttons;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressiveButton extends StatefulWidget {
  final Function onPressed;
  final String buttonText;
  final String processingText;
  final String successText;
  final String errorText;
  final bool hideBorder;
  const ProgressiveButton({super.key, required this.onPressed, required this.buttonText,  this.hideBorder = false, this.processingText = 'Processing', this.successText = 'Success', this.errorText = 'Error', });

  @override
  State<ProgressiveButton> createState() => _ProgressiveButtonState();
}

class _ProgressiveButtonState extends State<ProgressiveButton> {
  ValueNotifier<bool> buttonProcessing = ValueNotifier<bool>(false);
  ValueNotifier<String> actionStatus = ValueNotifier<String>('');

  double iconSize = 16.0;

  @override
  Widget build(BuildContext context) {

    Color buttonColor = Colors.transparent;
    Color buttonBorderColor = Colors.blueAccent;
    Color buttonTextColor = Colors.blueAccent;

    Color dangerColor = Colors.redAccent;
    Color successColor = Colors.greenAccent;




    var buttonStyling = OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      side: widget.hideBorder == true?BorderSide.none :BorderSide(
        width: 1.0,
        color: buttonBorderColor.withOpacity(0.5),
      ),
      backgroundColor: buttonColor,
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),

    );

    return Container(
      child: OutlinedButton(
        style: buttonStyling,
        onPressed: () async {
          if(buttonProcessing.value == true) return;

          actionStatus.value = '';

          buttonProcessing.value = true;

          await Future.delayed(Duration(milliseconds: 300));

          try{
            await widget.onPressed();
            actionStatus.value = 'success';
          }catch(e){
            actionStatus.value = 'error';
          }
          //wait for two seconds

          buttonProcessing.value = false;

          await Future.delayed(Duration(seconds: 1));

          actionStatus.value = '';
          buttonProcessing.notifyListeners();
        },
        child:ValueListenableBuilder(
            valueListenable: buttonProcessing,
            builder:(context, value, child) {
              return Flex(
                mainAxisAlignment: MainAxisAlignment.center,
                direction: Axis.horizontal,
                children: [

                  if(actionStatus.value == 'success')...[
                    Icon(Icons.check_rounded, color: buttonTextColor, size: iconSize+4),
                    if(widget.successText.isNotEmpty)...[
                      SizedBox(width: 10.0,),
                      Text(widget.successText, style: TextStyle(color: buttonTextColor,),),
                    ],
                  ]else if(actionStatus.value == 'error')...[
                    Icon(Icons.error_outline_rounded, color: dangerColor, size: iconSize+4),
                    if(widget.errorText.isNotEmpty)...[
                      SizedBox(width: 10.0,),
                      Text(widget.errorText, style: TextStyle(color: dangerColor,),),
                    ],
                  ]else if(value == true) ...[
                    CircularLoader(color: buttonTextColor,  size: iconSize, progressValue: 1),
                    if(widget.processingText.isNotEmpty)...[
                      SizedBox(width: 10.0,),
                      Text(widget.processingText, style: TextStyle(color: buttonTextColor,),),
                    ],
                  ]else...[
                    Text(widget.buttonText, style: TextStyle(color: buttonTextColor,),),
                  ],
                ],);

            }
        ),
        //child: Text(widget.buttonText, style: TextStyle(color: widget.textColor,),
      ),);
  }


  Widget CircularLoader({required progressValue, required Color color, double size = 34.0}){
    double finalProgressValue = 0.0;
    if(progressValue != null && progressValue  > 1){finalProgressValue = 1;}

    var finalLoaderColor = color;

    double loaderStrokeWidth = size/9;
    return Container(
      width: size,
      height: size,

      child: Center(


          child: CircularProgressIndicator(
            value: progressValue == null?null:finalProgressValue,
            strokeWidth: loaderStrokeWidth,
            valueColor: new AlwaysStoppedAnimation<Color>(finalLoaderColor),

          )),);
  }
}

