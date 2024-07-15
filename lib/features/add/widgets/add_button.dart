import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    required this.income,
    required this.active,
    required this.onPressed,
  });

  final bool income;
  final bool active;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 274,
      decoration: BoxDecoration(
        color: const Color(0xff87F0FF).withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: CupertinoButton(
        onPressed: active ? onPressed : null,
        padding: EdgeInsets.zero,
        child: Center(
          child: Text(
            'Add',
            style: TextStyle(
              color: active ? Colors.white : Colors.white.withOpacity(0.1),
              fontSize: 24,
              fontFamily: 'MontserratM',
            ),
          ),
        ),
      ),
    );
  }
}
