import 'package:flutter/material.dart';

class QuranTile extends StatelessWidget {

  final String quranTile;
  final bool isSelected;

  QuranTile({required this.quranTile,required this.isSelected});

  @override
  Widget build(BuildContext context) {
  return  Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(quranTile,style: TextStyle(fontSize: 16,
    color: isSelected ? Colors.blue : Colors.grey),),
  );
  }
}
