import 'package:flutter/material.dart';

import '../../app_logger.dart';

class SearchLabel extends StatelessWidget {
  SearchLabel(
      {super.key,
      this.onChanged,
      this.hintText,
      required this.width,
      required this.height,
      this.radius = 10});
  String? hintText;

  double width, height, radius;

  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        textDirection: TextDirection.ltr,
        style: const TextStyle(color: Colors.black),
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Handle search functionality here
              AppLogger.log('Searching for: ${onChanged?.call('')}');
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            borderSide: const BorderSide(color: Color(0xffDDDDDD)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
        ),
      ),
    );
  }
}