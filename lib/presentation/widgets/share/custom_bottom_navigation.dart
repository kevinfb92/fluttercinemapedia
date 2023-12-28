import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends BottomNavigationBar {
  CustomBottomNavigationBar({super.key})
      : super(elevation: 0, items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.home_max), label: 'Inicio'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.label_outline), label: 'Categorías'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline), label: 'Favoritos')
        ]);
}
