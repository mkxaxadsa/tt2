import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/utils.dart';
import '../../../core/widgets/page_title_card2.dart';
import '../../transaction/bloc/transaction_bloc.dart';
import '../widgets/plus_minus_button.dart';
import '../widgets/target_field.dart';

class BoxPage extends StatelessWidget {
  const BoxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PageTitleCard2(
          title: 'Money box',
          subtitle: 'Save up for your dream',
          height: 142,
        ),
        const SizedBox(height: 28),
        const TargetField(),
        const SizedBox(height: 36),
        BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            return Text(
              '\$${boxAmount.toStringAsFixed(0)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontFamily: 'MontserratB',
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        SvgPicture.asset(
          'assets/safe.svg',
          height: 243,
        ),
        const Spacer(),
        const Row(
          children: [
            SizedBox(width: 48),
            PlusMinusButton(plus: true),
            Spacer(),
            PlusMinusButton(plus: false),
            SizedBox(width: 48),
          ],
        ),
        const SizedBox(height: 83),
      ],
    );
  }
}
