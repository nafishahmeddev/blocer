import 'package:blocer/bloc/cubit/auth.dart';
import 'package:blocer/pages/onboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDarkMode?  Brightness.light: Brightness.dark
    ));

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>AuthCubit())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorSchemeSeed: Colors.green,
          useMaterial3: true,
          // textTheme: GoogleFonts.rubikTextTheme(
          //     isDarkMode? ThemeData.dark(useMaterial3: true).textTheme : ThemeData.light(useMaterial3: true).textTheme
          // ),
          brightness: isDarkMode? Brightness.dark: Brightness.light
        ),
        home: const OnboardPage(),
      ),
    );
  }
}