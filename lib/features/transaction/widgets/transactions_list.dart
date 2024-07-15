import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/models/transaction.dart';
import '../../../core/utils.dart';
import '../bloc/transaction_bloc.dart';
import 'delete_dialog.dart';

class TransactionsList extends StatefulWidget {
  const TransactionsList({super.key});

  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        height: expanded ? 500 + 76 : 108 + 76,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60),
            topRight: Radius.circular(60),
          ),
          gradient: LinearGradient(
            colors: [
              Color(0xff1937FE),
              Color(0xff3448D3),
            ],
          ),
        ),
        child: Column(
          children: [
            CupertinoButton(
              onPressed: () {
                setState(() {
                  expanded = !expanded;
                });
              },
              minSize: 36,
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 80,
              ),
              child: Container(
                height: 4,
                width: 47,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 8),
            _SearchField(
              controller: controller,
              onTap: (close) {
                setState(() {
                  if (close) {
                    expanded = false;
                  } else {
                    expanded = true;
                  }
                });
              },
            ),
            const SizedBox(height: 8),
            BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                if (state is TransactionsLoadedState) {
                  return Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      children: [
                        ...List.generate(
                          state.transactions.length,
                          (index) {
                            return _TransactionTile(
                              transaction: state.transactions[index],
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }

                return Container();
              },
            ),
            const SizedBox(height: 76),
          ],
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.onTap,
  });

  final TextEditingController controller;
  final void Function(bool) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      margin: const EdgeInsets.symmetric(horizontal: 35),
      decoration: BoxDecoration(
        color: const Color(0xff05199E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        textCapitalization: TextCapitalization.sentences,
        inputFormatters: [
          LengthLimitingTextInputFormatter(10),
        ],
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w800,
          fontFamily: 'SFB',
        ),
        decoration: const InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(
            color: Color(0xff3D56FA),
            fontSize: 18,
            fontWeight: FontWeight.w800,
            fontFamily: 'SFB',
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: Color(0xff3D56FA),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onTap: () {
          onTap(false);
        },
        onChanged: (value) {
          context
              .read<TransactionBloc>()
              .add(SearchTransactionEvent(text: value));
        },
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({required this.transaction});

  final Transaction transaction;

  Color getColor(String title) {
    switch (title) {
      case 'Travel':
        return const Color(0xffFF8787);
      case 'Shopping':
        return const Color(0xffFFCF87);
      case 'Sport':
        return const Color(0xff87F0FF);
      case 'Medicine':
        return const Color(0xffE09FFF);
      case 'Work':
        return const Color(0xffE2842E);
      case 'Cash':
        return const Color(0xff87E73B);
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const SizedBox(width: 28),
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: getColor(transaction.category),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/${transaction.category.toLowerCase()}.svg',
              ),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.category,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${formatDateString(transaction.date)}, ${formatTime(transaction.id)}',
                style: const TextStyle(
                  color: Color(0xff80E0FF),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            transaction.income
                ? '+\$${transaction.amount.toStringAsFixed(0)}'
                : '-\$${transaction.amount.toStringAsFixed(0)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          CupertinoButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return DeleteDialog(
                    onYes: () {
                      context
                          .read<TransactionBloc>()
                          .add(DeleteTransactionEvent(id: transaction.id));
                    },
                  );
                },
              );
            },
            minSize: 40,
            padding: EdgeInsets.zero,
            child: const Icon(
              Icons.close_rounded,
              color: Color(0xff80E0FF),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
