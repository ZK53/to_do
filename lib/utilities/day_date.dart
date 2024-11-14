import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayDate extends StatelessWidget {
  DayDate({super.key});

  final String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Text(
      today,
      style: const TextStyle(fontSize: 16),
    );
  }
}
