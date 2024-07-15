import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:date_picker_plus/date_picker_plus.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/utils.dart';

class AmountField extends StatelessWidget {
  const AmountField({
    super.key,
    required this.controller,
    required this.onChanged,
    this.onDate,
  });

  final TextEditingController controller;
  final void Function() onChanged;
  final void Function(String)? onDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57,
      width: 258,
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 4,
        top: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.button,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        textCapitalization: TextCapitalization.sentences,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(6),
          // LengthLimitingTextInputFormatter(limit),
        ],
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w700,
          fontFamily: 'MontserratB',
        ),
        readOnly: onDate != null,
        decoration: const InputDecoration(
          hintText: '\$ 0',
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            fontFamily: 'MontserratB',
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          // focusedBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: Colors.transparent),
          // ),
          // enabledBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: Colors.transparent),
          // ),
        ),
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onChanged: (value) {
          onChanged();
        },
        onTap: () async {
          if (onDate != null) {
            final date = await showDatePickerDialog(
              context: context,
              leadingDateTextStyle: const TextStyle(
                color: Color(0xffff0000),
                fontWeight: FontWeight.w700,
                fontFamily: 'MontserratM',
              ),
              currentDateTextStyle: const TextStyle(
                color: Color(0xffff0000),
              ),
              enabledCellsTextStyle: const TextStyle(
                color: Color(0xffff0000),
              ),
              currentDateDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xffff0000)),
              ),
              daysOfTheWeekTextStyle: const TextStyle(
                color: Color(0xff3d3d40),
                fontSize: 12,
                fontWeight: FontWeight.w600,
                fontFamily: 'MontserratM',
              ),
              slidersColor: const Color(0xffff0000),
              currentDate: convertToDateTime(controller.text),
              minDate: DateTime(2020, 1, 1),
              maxDate: DateTime(2030, 1, 1),
              padding: EdgeInsets.zero,
              contentPadding: const EdgeInsets.all(8),
              height: 309,
            );
            onDate!(formatDateTime(date ?? convertToDateTime(controller.text)));
          }
        },
      ),
    );
  }
}
