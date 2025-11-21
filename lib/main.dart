import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/order_cubit.dart';
import 'pages/order_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cafe Adchrisa',
        theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Colors.green.shade700,
          scaffoldBackgroundColor: const Color(0xFFF3F7F3),
          appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.green.shade700,
            foregroundColor: Colors.white,
            centerTitle: false,
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87),
            bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),
            bodySmall: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.green.shade700,
            unselectedItemColor: Colors.grey.shade500,
          ),
        ),
        home: const OrderHomePage(),
      ),
    );
  }
}
