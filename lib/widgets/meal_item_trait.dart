import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget {
  const MealItemTrait({
    super.key,
    required this.icon,
    required this.label,
    this.iconColor,
    this.textStyle,
    this.iconSize = 17, // Added a default value for icon size
    this.spacing =
        6, // Added a default value for spacing between the icon and text
  });

  final IconData icon;
  final String label;
  final Color? iconColor; // Customizable icon color
  final TextStyle? textStyle; // Customizable text style
  final double iconSize; // Customizable icon size
  final double spacing; // Customizable space between icon and text

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // Align to the start (left)
      children: [
        Icon(
          icon,
          size: iconSize, // Use the custom icon size
          color: iconColor ??
              Colors.white, // Use custom icon color (or default to white)
        ),
        SizedBox(
          width: spacing, // Use custom spacing between icon and text
        ),
        Text(
          label,
          style: textStyle ??
              TextStyle(
                color: Colors.white, // Default text color is white
              ),
        ),
      ],
    );
  }
}
