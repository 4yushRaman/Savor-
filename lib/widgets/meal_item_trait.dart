// import 'package:flutter/material.dart';

// class MealItemTrait extends StatelessWidget {
//   const MealItemTrait({
//     super.key,
//     required this.icon,
//     required this.label,
//   });

//   final IconData icon;
//   final String label;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(
//           icon,
//           size: 17,
//           color: Colors.white,
//         ),
//         const SizedBox(
//           width: 6,
//         ),
//         Text(
//           label,
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget {
  const MealItemTrait({
    super.key,
    required this.icon,
    required this.label,
    this.iconColor,
    this.textStyle,
  });

  final IconData icon;
  final String label;
  final Color? iconColor; // Allow custom icon color
  final TextStyle? textStyle; // Allow custom text style

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: iconColor ??
              Colors.white, // Default to white if no color is provided
        ),
        const SizedBox(
          width: 6,
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
