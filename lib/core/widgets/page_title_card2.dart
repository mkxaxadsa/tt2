import 'package:flutter/material.dart';

class PageTitleCard2 extends StatelessWidget {
  const PageTitleCard2({
    super.key,
    required this.title,
    this.subtitle = '',
    this.amount = '',
    required this.height,
  });

  final String title;
  final String subtitle;
  final String amount;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height + 4,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: const EdgeInsets.all(32),
          decoration: const BoxDecoration(
            color: Color(0xff87F0FF),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(55),
              bottomRight: Radius.circular(55),
            ),
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
            ),
          ),
        ),
        Container(
          height: height,
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff363BB6),
                Color(0xff06136B),
              ],
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              if (subtitle.isNotEmpty)
                Center(
                  child: Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xffBEECF3),
                      fontSize: 20,
                    ),
                  ),
                ),
              const SizedBox(height: 32),
              if (amount.isNotEmpty) ...[
                Center(
                  child: Text(
                    amount,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'MontserratB',
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
