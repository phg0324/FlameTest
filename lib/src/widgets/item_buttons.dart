import 'package:flutter/material.dart';

class ItemButtons extends StatelessWidget {
  final List<int> itemCounts;
  final Function(int) onItemPressed;
  final List<String> itemImages; // 각 아이템의 이미지 경로 리스트

  ItemButtons({
    required this.itemCounts,
    required this.onItemPressed,
    required this.itemImages,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      left: 10,
      child: Row(
        children: List.generate(itemCounts.length, (index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed:
                  itemCounts[index] > 0 ? () => onItemPressed(index) : null,
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/items/${itemImages[index]}', // 아이템 이미지 경로 사용
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 8),
                  Text('${itemCounts[index]}'),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
