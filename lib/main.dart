import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/pokemon_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokemon App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: PokemonListScreen(),
    );
  }
  }

