

import 'package:cobaKelolaProduk/screens/productScreen.dart';
import 'package:cobaKelolaProduk/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  LazyUi.config(
      radius: 5,
      primaryColor: LzColors.dark,
      theme: AppTheme.light,
      textStyle: GoogleFonts.nunito(fontSize: 15.5),
      iconType: IconType.tablerIcon);

  runApp(const ProviderScope(
      child: MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App List',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home:  ProductListView(),
      builder: (BuildContext context, Widget? widget) {
        double fontDeviceSize = MediaQuery.of(context).textScaleFactor;

        // prevent user from scaling font size
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: fontDeviceSize > 1.1 ? 1.1 : 1.0,
            ),
            child: LzToastOverlay(child: widget));
      },
    );
  }
}