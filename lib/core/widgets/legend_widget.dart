import 'package:flutter/material.dart';

class LegendWidget extends StatelessWidget {
  const LegendWidget({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: '$label : ',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 11),
        children: [
          TextSpan(
            text: value,
            style:
                Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 11),
          ),
        ],
      ),
    );
  }
}
