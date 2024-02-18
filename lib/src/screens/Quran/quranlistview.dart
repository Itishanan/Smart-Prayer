import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuranTile extends StatelessWidget {
  final String quranTile;
  final bool isSelected;
  final VoidCallback onTap;

  const QuranTile({
    required this.quranTile,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          quranTile,
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? Colors.blue : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            decoration: isSelected ? TextDecoration.underline : TextDecoration.none,
          ),
        ),
      ),
    );
  }
}

class QuranController extends GetxController {
  final selectedIndex = 0.obs;

  void setPageIndex(int index) {
    selectedIndex.value = index;

  }
}

