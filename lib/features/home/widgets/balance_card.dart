import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils.dart';
import '../../transaction/bloc/transaction_bloc.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 38),
      padding: const EdgeInsets.symmetric(horizontal: 26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(0.1),
            blurRadius: 50,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 32),
          const Row(
            children: [
              SizedBox(width: 4),
              Text(
                'Your total balance',
                style: TextStyle(
                  color: Color(0xff3A3A3A),
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const SizedBox(width: 4),
              Text(
                '\$${getTotalBalance()}',
                style: const TextStyle(
                  color: Color(0xff2D99FF),
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'MontserratB',
                ),
              ),
            ],
          ),
          const SizedBox(height: 27),
          BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              return SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _BarChart(getHeight(w1i, w1e)),
                    _BarChart(getHeight(w2i, w2e)),
                    _BarChart(getHeight(w3i, w3e)),
                    _BarChart(getHeight(w4i, w4e)),
                    _BarChart(getHeight(w5i, w5e)),
                    _BarChart(getHeight(w6i, w6e)),
                    _BarChart(getHeight(w7i, w7e)),
                    const SizedBox(width: 9),
                  ],
                ),
              );
            },
          ),
          BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              return SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 9),
                    _BarChart2(getHeight(w1e, w1i)),
                    _BarChart2(getHeight(w2e, w2i)),
                    _BarChart2(getHeight(w3e, w3i)),
                    _BarChart2(getHeight(w4e, w4i)),
                    _BarChart2(getHeight(w5e, w5i)),
                    _BarChart2(getHeight(w6e, w6i)),
                    _BarChart2(getHeight(w7e, w7i)),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _BarChart extends StatelessWidget {
  const _BarChart(this.height);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: 9,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        color: Color(0xff2D99FF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(3),
          topRight: Radius.circular(3),
        ),
      ),
    );
  }
}

class _BarChart2 extends StatelessWidget {
  const _BarChart2(this.height);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: 9,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        color: Color(0xffA5F3FF),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(3),
          bottomRight: Radius.circular(3),
        ),
      ),
    );
  }
}
