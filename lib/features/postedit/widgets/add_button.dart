import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onTap;
  final double width;

  const AddButton({
    super.key,
    required this.onTap,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.black12,
        width: width,
        height: width,
        child: const Icon(
          Icons.add,
          size: 48,
          color: Colors.black38,
        ),
      ),
    );
  }
}
