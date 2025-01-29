import 'package:ai_matematik/router/app_router.dart';
import 'package:ai_matematik/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
    MyApp({super.key});
  var mainRoute = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primaryColorLight: ColorHelper.primary,
        iconTheme: IconThemeData(color: ColorHelper.iconLight),
        primaryColor: ColorHelper.primary,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: ColorHelper.iconLight,
            unselectedItemColor: ColorHelper.iconLight),
        splashColor: ColorHelper.appBarBackgroundLightColor,
        scaffoldBackgroundColor: ColorHelper.scaffoldBackgroundLightColor,
        secondaryHeaderColor: ColorHelper.textColor,
        textTheme: GoogleFonts.poppinsTextTheme(),
        appBarTheme: AppBarTheme(
          titleTextStyle:
          GoogleFonts.poppins(color: ColorHelper.textColor, fontSize: 24),
          backgroundColor: ColorHelper.appBarBackgroundLightColor,
          iconTheme: IconThemeData(
            color: ColorHelper.primary, // Change back button color here
          ),
        ),
      ),
      darkTheme: ThemeData(
        primaryColorLight: ColorHelper.primary,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: ColorHelper.iconDark,
            unselectedItemColor: ColorHelper.iconDark),
        iconTheme: IconThemeData(color: ColorHelper.iconDark),
        splashColor: ColorHelper.appBarBackgroundDarkColor,
        primaryColor: ColorHelper.primaryDark,
        scaffoldBackgroundColor: ColorHelper.scaffoldBackgroundDarkColor,
        secondaryHeaderColor: ColorHelper.textColorDark,
        textTheme: GoogleFonts.poppinsTextTheme(),
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.poppins(
              color: ColorHelper.textColorDark,
              fontWeight: FontWeight.w600,
              fontSize: 24),
          backgroundColor: ColorHelper.appBarBackgroundDarkColor,
          iconTheme: IconThemeData(
            color: ColorHelper.textColorDark, // Change back button color here
          ),
        ),
      ),
      routerConfig: mainRoute.config(),
    );
  }
}
