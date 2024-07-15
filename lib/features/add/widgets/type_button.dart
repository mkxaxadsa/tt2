import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/config/app_colors.dart';

class TypeButton extends StatelessWidget {
  const TypeButton({
    super.key,
    required this.income,
    required this.active,
    required this.onPressed,
  });

  final bool income;
  final bool active;
  final void Function(bool) onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          color: income ? const Color(0xff168528) : const Color(0xff9A2617),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 3,
            color: active ? AppColors.main : Colors.transparent,
          ),
        ),
        child: CupertinoButton(
          onPressed: () {
            onPressed(income);
          },
          padding: EdgeInsets.zero,
          child: Center(
            child: Text(
              income ? 'Income' : 'Expenses',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
