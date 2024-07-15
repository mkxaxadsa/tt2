import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../../core/widgets/page_title_card2.dart';
import '../../transaction/bloc/transaction_bloc.dart';

class PlusMinusPage extends StatefulWidget {
  const PlusMinusPage({super.key, required this.plus});

  final bool plus;

  @override
  State<PlusMinusPage> createState() => _PlusMinusPageState();
}

class _PlusMinusPageState extends State<PlusMinusPage> {
  final controller = TextEditingController();

  void onTap(String value) {
    if (controller.text.length < 6) {
      setState(() {
        controller.text += value;
      });
    }
  }

  void onAdd() async {
    if (controller.text.isNotEmpty) {
      await saveBoxAmount(
        double.tryParse(controller.text) ?? 0,
        widget.plus,
      ).then((value) {
        context.read<TransactionBloc>().add(GetTransactionsEvent());
        context.pop();
      });
    } else {
      context.pop();
    }
  }

  void onClear() {
    if (controller.text.isNotEmpty) {
      setState(() {
        controller.text =
            controller.text.substring(0, controller.text.length - 1);
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          PageTitleCard2(
            title: widget.plus ? 'Replenishment' : 'Сonsumption',
            height: 117,
          ),
          const SizedBox(height: 40),
          const Text(
            'Enter Amount',
            style: TextStyle(
              color: AppColors.main,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            controller.text.isNotEmpty ? '\$ ${controller.text}' : '\$ 0',
            style: const TextStyle(
              color: AppColors.main,
              fontSize: 36,
              fontWeight: FontWeight.w700,
              fontFamily: 'MontserratB',
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            width: 224,
            color: Colors.white,
          ),
          const SizedBox(height: 16),
          Text(
            widget.plus ? 'To' : 'From',
            style: const TextStyle(
              color: AppColors.main,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 23),
          Text(
            boxTarget,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Button('1', onTap: onTap),
              const SizedBox(width: 10),
              _Button('2', onTap: onTap),
              const SizedBox(width: 10),
              _Button('3', onTap: onTap),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Button('4', onTap: onTap),
              const SizedBox(width: 10),
              _Button('5', onTap: onTap),
              const SizedBox(width: 10),
              _Button('6', onTap: onTap),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Button('7', onTap: onTap),
              const SizedBox(width: 10),
              _Button('8', onTap: onTap),
              const SizedBox(width: 10),
              _Button('9', onTap: onTap),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Button('clear', onClear: onClear),
              const SizedBox(width: 10),
              _Button('0', onTap: onTap),
              const SizedBox(width: 10),
              _Button('add', onAdd: onAdd),
            ],
          ),
          const SizedBox(height: 70),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button(
    this.title, {
    this.onTap,
    this.onAdd,
    this.onClear,
  });

  final String title;
  final void Function(String)? onTap;
  final void Function()? onAdd;
  final void Function()? onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 90,
      decoration: BoxDecoration(
        color: title == 'add' || title == 'clear'
            ? AppColors.main
            : const Color(0xffF5F6F8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: CupertinoButton(
        onPressed: () {
          if (title == 'clear') {
            onClear!();
          } else if (title == 'add') {
            onAdd!();
          } else {
            onTap!(title);
          }
        },
        padding: EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (title == 'clear')
              const Text(
                'C',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontFamily: 'Montserrat',
                ),
              )
            else if (title == 'add')
              SvgPicture.asset(
                'assets/arrow.svg',
                height: 21,
              )
            else
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.main,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'MontserratM',
                ),
              ),
          ],
        ),
      ),
    );
  }
}
