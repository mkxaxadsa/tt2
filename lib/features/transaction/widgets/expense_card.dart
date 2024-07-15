import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils.dart';
import '../bloc/transaction_bloc.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({
    super.key,
    required this.title,
  });

  final String title;

  Color getColor(String title) {
    switch (title) {
      case 'Travel':
        return const Color(0xffA73131);
      case 'Shopping':
        return const Color(0xffA27430);
      case 'Sport':
        return const Color(0xff3593A0);
      case 'Medicine':
        return const Color(0xff9137BC);
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 103,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: [
              if (title == 'Travel') ...[
                const Color(0xffFF8787),
                const Color(0xffC16A6A),
              ],
              if (title == 'Shopping') ...[
                const Color(0xffFFCF87),
                const Color(0xffCA9547),
              ],
              if (title == 'Sport') ...[
                const Color(0xff87F0FF),
                const Color(0xff59A0AA),
              ],
              if (title == 'Medicine') ...[
                const Color(0xffE09FFF),
                const Color(0xff8A46AB),
              ],
            ],
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Stack(
            children: [
              Positioned(
                top: -15,
                left: -9,
                child: Container(
                  height: 112,
                  width: 112,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(56),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        if (title == 'Travel') ...[
                          const Color(0xffF78C8C).withOpacity(0),
                          const Color(0xffF78C8C),
                        ],
                        if (title == 'Shopping') ...[
                          const Color(0xffF6CF7A).withOpacity(0),
                          const Color(0xffF6CF7A),
                        ],
                        if (title == 'Sport') ...[
                          const Color(0xff87F0FF).withOpacity(0),
                          const Color(0xff87F0FF),
                        ],
                        if (title == 'Medicine') ...[
                          const Color(0xffE88FFF).withOpacity(0),
                          const Color(0xffE88FFF),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 24,
                left: 16,
                child: Text(
                  title,
                  style: TextStyle(
                    color: getColor(title),
                    fontSize: 18,
                  ),
                ),
              ),
              BlocBuilder<TransactionBloc, TransactionState>(
                builder: (context, state) {
                  return Positioned(
                    bottom: 24,
                    left: 16,
                    child: Text(
                      '\$${getCategoryTotalAmount(title)}',
                      style: TextStyle(
                        color: getColor(title),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'MontserratB',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
