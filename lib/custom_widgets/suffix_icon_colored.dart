import 'package:flutter/material.dart';

class SuffixIconColored extends StatelessWidget {
  final double iconSize;
  final Color iconColor;
  final IconData icon;
  final VoidCallback? onPressedAction;
  final String? parentKey;

  const SuffixIconColored({
    super.key,
    required this.iconSize,
    required this.iconColor,
    required this.icon,
    this.onPressedAction,
    this.parentKey,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      //ignore the icon going to the next element to focus
      focusNode: FocusNode(skipTraversal: true),
      icon: Icon(
        key: Key('${parentKey ?? 'textField'}SuffixIcon'),
        icon,
        color: iconColor,
        size: iconSize,
      ),
      onPressed: onPressedAction,
      //remove the shadow animation feedback on the click on the icon
      splashColor: Colors.transparent,
    );
  }
}
