import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;
  final FocusNode? focusNode;

  const PrimaryButton({
    required this.child,
    required this.onPressed,
    this.focusNode,
    Key? key,
  }) : super(key: key);

  PrimaryButton.text(
      {required String text, required this.onPressed, Key? key, this.focusNode})
      : child = Text(text),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          child: child,
          focusNode: focusNode,
        ));
  }
}
