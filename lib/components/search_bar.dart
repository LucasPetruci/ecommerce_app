import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  final String placeholder;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const MySearchBar(
      {super.key,
      this.placeholder = 'Search',
      this.controller,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: placeholder,
                border: InputBorder.none,
              ),
            ),
          ),
          GestureDetector(
            child: const Icon(
              Icons.search,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
