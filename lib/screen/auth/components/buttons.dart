import 'package:ai_matematik/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key, required this.onTap});

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap();
      },
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.white),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      leading: SvgPicture.asset(
        "assets/icon/ic_google.svg",
        width: 24,
        height: 24,
      ),
      title: Text(
        "Sign in with Google",
        style: GoogleFonts.poppins(
          color: ColorHelper.textColor,
          fontWeight: FontWeight.w600,
          fontSize: 16
        ),
      ),
    );
  }
}
