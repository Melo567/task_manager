import 'package:flutter/material.dart';

class LegendWidget extends StatelessWidget {
  const LegendWidget({
    super.key,
    required this.label,
    required this.value,
    this.fontSize = 10,
  });

  final String label;
  final String value;

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: '$label : ',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: fontSize,
            ),
        children: [
          TextSpan(
            text: value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: fontSize,
                ),
          ),
        ],
      ),
    );
  }
}
