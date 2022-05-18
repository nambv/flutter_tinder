import 'package:flutter/material.dart';

class TDTextButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Color textColor;
  final Function() onPressed;

  const TDTextButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.textColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: TextButton.icon(
        icon: icon,
        label: Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        style: TextButton.styleFrom(primary: textColor),
        onPressed: onPressed,
      ),
    );
  }
}
