import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'colors.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({super.key, required this.show});

  final bool show;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: show,
      child: Container(
        decoration: BoxDecoration(color: ColorHelper.transparentPrimary),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: LoadingAnimationWidget.threeRotatingDots(
            size: 100,
            color: ColorHelper.primary,
          ),
        ),
      ),
    );
  }
}

void appShowErrorDialog(String text, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
          title: Text(
        text,
        style: GoogleFonts.poppins(
            fontSize: 14, fontWeight: FontWeight.w500, color: ColorHelper.red),
      ),
        actions: [
          CupertinoDialogAction(
            child: Text('Cancel'),
            onPressed: () {
              // Close the dialog
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('OK'),
            onPressed: () {
              // Perform an action and close the dialog
              print('OK Pressed');
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
