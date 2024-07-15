import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money4/core/models/transaction.dart';
import 'package:money4/features/transaction/bloc/transaction_bloc.dart';

import '../../../core/utils.dart';
import '../../../core/widgets/page_title_card.dart';
import '../../home/bloc/home_bloc.dart';
import '../widgets/add_button.dart';
import '../widgets/amount_field.dart';
import '../widgets/category_button.dart';
import '../widgets/type_button.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  final controller4 = TextEditingController();

  bool income = false;
  bool active = false;

  void checkActive() {
    setState(() {
      if (controller1.text.isEmpty) {
        active = false;
      } else if (controller2.text.isEmpty) {
        active = false;
      } else if (controller3.text.isEmpty && income) {
        active = false;
      } else if (controller4.text.isEmpty && !income) {
        active = false;
      } else {
        active = true;
      }
    });
  }

  void onType(bool value) {
    income = value;
    checkActive();
  }

  void onDate(String value) {
    controller2.text = value;
    checkActive();
  }

  void onCategory(String value) {
    if (income) {
      controller3.text = value;
    } else {
      controller4.text = value;
    }
    checkActive();
  }

  void onAdd() async {
    context.read<TransactionBloc>().add(
          AddTransactionEvent(
            transaction: Transaction(
              id: getCurrentTimestamp(),
              income: income,
              amount: double.tryParse(controller1.text) ?? 0,
              date: controller2.text,
              category: income ? controller3.text : controller4.text,
            ),
          ),
        );
    expanded = true;
    context.read<HomeBloc>().add(ChangePageEvent(index: 2));
  }

  @override
  void initState() {
    super.initState();
    controller2.text = formatDateTime(DateTime.now());
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PageTitleCard(
          title: 'Add transaction',
          height: 135,
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            const SizedBox(width: 32),
            TypeButton(
              income: true,
              active: income,
              onPressed: onType,
            ),
            const SizedBox(width: 28),
            TypeButton(
              income: false,
              active: !income,
              onPressed: onType,
            ),
            const SizedBox(width: 32),
          ],
        ),
        const SizedBox(height: 24),
        const _Text('Enter the amount'),
        const SizedBox(height: 16),
        AmountField(
          controller: controller1,
          onChanged: checkActive,
        ),
        const SizedBox(height: 24),
        const _Text('Enter the date'),
        const SizedBox(height: 16),
        AmountField(
          controller: controller2,
          onChanged: checkActive,
          onDate: onDate,
        ),
        const SizedBox(height: 24),
        const _Text('Choose a category'),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (income) ...[
              CategoryButton(
                title: 'Work',
                color: const Color(0xffE2842E),
                active: controller3.text == 'Work',
                onPressed: onCategory,
              ),
              const SizedBox(width: 32),
              CategoryButton(
                title: 'Cash',
                color: const Color(0xff87E73B),
                active: controller3.text == 'Cash',
                onPressed: onCategory,
              ),
            ] else ...[
              CategoryButton(
                title: 'Shopping',
                color: const Color(0xffFFCF87),
                active: controller4.text == 'Shopping',
                onPressed: onCategory,
              ),
              const SizedBox(width: 32),
              CategoryButton(
                title: 'Medicine',
                color: const Color(0xffE09FFF),
                active: controller4.text == 'Medicine',
                onPressed: onCategory,
              ),
              const SizedBox(width: 32),
              CategoryButton(
                title: 'Sport',
                color: const Color(0xff87F0FF),
                active: controller4.text == 'Sport',
                onPressed: onCategory,
              ),
              const SizedBox(width: 32),
              CategoryButton(
                title: 'Travel',
                color: const Color(0xffFF8787),
                active: controller4.text == 'Travel',
                onPressed: onCategory,
              ),
            ],
          ],
        ),
        const Spacer(),
        AddButton(
          income: income,
          active: active,
          onPressed: onAdd,
        ),
        const SizedBox(height: 34 + 76),
      ],
    );
  }
}

class _Text extends StatelessWidget {
  const _Text(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontFamily: 'MontserratM',
      ),
    );
  }
}
