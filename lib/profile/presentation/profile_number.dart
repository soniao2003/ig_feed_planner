import 'package:flutter/material.dart';

class ProfileNumber extends StatelessWidget {
  const ProfileNumber({
    super.key,
    required this.amount,
    required this.name,
  });
  final String amount;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          amount,
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
        ),
        Text(
          name,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ],
    );
  }
}
