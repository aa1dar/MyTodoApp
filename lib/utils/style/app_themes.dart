import 'package:flutter/material.dart';
import 'package:todo_app/utils/style/app_colors.dart';

class AppTheme {
  static const appBarIconSplashRadius = Material.defaultSplashRadius * 0.5;
  static const _lightTextTheme = TextTheme(
      titleLarge: TextStyle(
          fontSize: 32.0,
          height: 1.1875,
          fontWeight: FontWeight.w500,
          color: AppColor.labelLightPrimary),
      titleMedium: TextStyle(
          fontSize: 20.0,
          height: 1.6,
          fontWeight: FontWeight.w500,
          color: AppColor.labelLightPrimary),
      labelLarge: TextStyle(
          fontSize: 14.0,
          height: 1.714,
          fontWeight: FontWeight.w500,
          color: AppColor.labelLightPrimary),
      bodyMedium: TextStyle(
          fontSize: 16.0,
          height: 1.25,
          fontWeight: FontWeight.w400,
          color: AppColor.labelLightPrimary),
      titleSmall: TextStyle(
          fontSize: 14.0,
          height: 1.4286,
          fontWeight: FontWeight.w400,
          color: AppColor.labelLightPrimary));

  static const _darkTextTheme = TextTheme(
      titleLarge: TextStyle(
          fontSize: 32.0,
          height: 1.1875,
          fontWeight: FontWeight.w500,
          color: AppColor.labelDarkPrimary),
      titleMedium: TextStyle(
          fontSize: 20.0,
          height: 1.6,
          fontWeight: FontWeight.w500,
          color: AppColor.labelDarkPrimary),
      labelLarge: TextStyle(
          fontSize: 14.0,
          height: 1.714,
          fontWeight: FontWeight.w500,
          color: AppColor.labelDarkPrimary),
      bodyMedium: TextStyle(
          fontSize: 16.0,
          height: 1.25,
          fontWeight: FontWeight.w400,
          color: AppColor.labelDarkPrimary),
      titleSmall: TextStyle(
          fontSize: 14.0,
          height: 1.4286,
          fontWeight: FontWeight.w400,
          color: AppColor.labelDarkPrimary));

  static ThemeData lightTheme() => ThemeData(
      useMaterial3: false,
      datePickerTheme: const DatePickerThemeData(
        rangeSelectionOverlayColor: MaterialStatePropertyAll(Colors.red),
        weekdayStyle: TextStyle(
            color: AppColor.labelLightTertiary, fontSize: 12, height: 1.67),
        yearForegroundColor:
            MaterialStatePropertyAll(AppColor.labelLightPrimary),
        dayForegroundColor:
            MaterialStatePropertyAll(AppColor.labelLightPrimary),
        surfaceTintColor: Colors.white,
        headerForegroundColor: AppColor.colorLightWhite,
        backgroundColor: AppColor.backLightSecondary,
        todayBorder: BorderSide(color: AppColor.colorLightBlue),
        headerBackgroundColor: AppColor.colorLightBlue,
      ),
      cardColor: AppColor.backLightSecondary,
      scaffoldBackgroundColor: AppColor.backLightPrimary,
      fontFamily: 'Roboto',
      primaryColor: AppColor.colorLightBlue,
      colorScheme: const ColorScheme.light().copyWith(
          primary: AppColor.colorLightBlue,
          secondary: AppColor.colorLightBlue,
          onSurface: AppColor.labelLightPrimary,
          brightness: Brightness.light,
          tertiary: AppColor.labelLightTertiary,
          tertiaryContainer: AppColor.colorLightGray,
          error: AppColor.colorLightRed,
          secondaryContainer: AppColor.colorLightGreen,
          surface: AppColor.labelLightDisable),
      primaryIconTheme: const IconThemeData(color: AppColor.labelLightPrimary),
      iconTheme: const IconThemeData(color: AppColor.colorLightWhite),
      switchTheme: SwitchThemeData(trackColor:
          MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return AppColor.colorLightBlue.withOpacity(0.3);
        }
        return AppColor.supprotLightOverlay;
      }), thumbColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return AppColor.colorLightBlue;
        }
        return AppColor.backLightElevated;
      })),
      checkboxTheme: const CheckboxThemeData(
          fillColor: MaterialStatePropertyAll(AppColor.supportLightSeparator),
          checkColor: MaterialStatePropertyAll(AppColor.backLightSecondary)),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColor.colorLightBlue,
          foregroundColor: AppColor.colorLightWhite),
      dividerColor: AppColor.supportLightSeparator,
      textTheme: _lightTextTheme,
      buttonTheme: const ButtonThemeData(
          buttonColor: AppColor.colorLightBlue,
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          alignedDropdown: false),
      appBarTheme: const AppBarTheme(
        color: AppColor.backLightPrimary,
        surfaceTintColor: AppColor.backLightPrimary,
        centerTitle: true,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: _lightTextTheme.bodyMedium!
            .copyWith(color: AppColor.labelLightTertiary),
        border: InputBorder.none,
      ),
      textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColor.supportLightSeparator,
          selectionColor: AppColor.colorLightGrayLight,
          selectionHandleColor: AppColor.colorLightGray));

  static ThemeData darkTheme() => ThemeData(
      useMaterial3: false,
      datePickerTheme: const DatePickerThemeData(
        rangeSelectionOverlayColor: MaterialStatePropertyAll(Colors.red),
        weekdayStyle: TextStyle(
            color: AppColor.labelDarkTertiary, fontSize: 12, height: 1.67),
        yearForegroundColor: MaterialStatePropertyAll(AppColor.colorDarkWhite),
        dayForegroundColor: MaterialStatePropertyAll(AppColor.colorDarkWhite),
        surfaceTintColor: Colors.white,
        headerForegroundColor: AppColor.colorDarkWhite,
        backgroundColor: AppColor.backDarkSecondary,
        todayBorder: BorderSide(color: AppColor.colorDarkBlue),
        headerBackgroundColor: AppColor.colorDarkBlue,
      ),
      cardColor: AppColor.backDarkSecondary,
      scaffoldBackgroundColor: AppColor.backDarkPrimary,
      fontFamily: 'Roboto',
      primaryColor: AppColor.colorDarkBlue,
      colorScheme: const ColorScheme.light().copyWith(
          primary: AppColor.colorDarkBlue,
          secondary: AppColor.colorDarkBlue,
          onSurface: AppColor.labelDarkPrimary,
          brightness: Brightness.light,
          tertiary: AppColor.labelDarkTertiary,
          tertiaryContainer: AppColor.colorDarkGray,
          error: AppColor.colorDarkRed,
          secondaryContainer: AppColor.colorDarkGreen,
          surface: AppColor.labelDarkDisable),
      primaryIconTheme: const IconThemeData(color: AppColor.labelDarkPrimary),
      iconTheme: const IconThemeData(color: AppColor.colorDarkWhite),
      switchTheme: SwitchThemeData(trackColor:
          MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return AppColor.colorDarkBlue.withOpacity(0.3);
        }
        return AppColor.supprotDarkOverlay;
      }), thumbColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return AppColor.colorDarkBlue;
        }
        return AppColor.backDarkElevated;
      })),
      checkboxTheme: const CheckboxThemeData(
          fillColor: MaterialStatePropertyAll(AppColor.supportDarkSeparator),
          checkColor: MaterialStatePropertyAll(AppColor.backDarkSecondary)),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColor.colorDarkBlue,
          foregroundColor: AppColor.colorDarkWhite),
      dividerColor: AppColor.supportDarkSeparator,
      textTheme: _darkTextTheme,
      buttonTheme: const ButtonThemeData(
          buttonColor: AppColor.colorDarkBlue,
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          alignedDropdown: false),
      appBarTheme: const AppBarTheme(
        color: AppColor.backDarkPrimary,
        surfaceTintColor: AppColor.backDarkPrimary,
        centerTitle: true,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: _lightTextTheme.bodyMedium!
            .copyWith(color: AppColor.labelDarkTertiary),
        border: InputBorder.none,
      ),
      textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColor.supportDarkSeparator,
          selectionColor: AppColor.colorDarkGrayLight,
          selectionHandleColor: AppColor.colorLightGray));
}
