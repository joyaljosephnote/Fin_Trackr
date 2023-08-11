import 'package:flutter/material.dart';

class MonthAndDatePicker {
  void datePicker({required BuildContext context}) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2500),
    );
  }
}
