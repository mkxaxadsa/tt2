import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:money4/core/utils.dart';

import '../../core/config/app_colors.dart';
import '../../core/widgets/custom_scaffold.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  int pageIndex = 0;

  String title = 'Keep an eye on your spending';
  String subtitle = 'Teach you how to take control of your finances';

  void onNext() async {
    setState(() {
      pageIndex++;
      if (pageIndex == 1) {
        title = 'Save up for your dream';
        subtitle = 'Here\'s a handy piggy bank to keep your savings in check';
      }
      if (pageIndex == 2) {
        title = 'Control expenses by category';
        subtitle = 'Control each category and manage your finances';
      }
    });
    if (pageIndex == 3) {
      await saveData().then((value) {
        context.go('/home');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            SvgPicture.asset('assets/onboard1.svg'),
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Positioned(
                    left: -100,
                    bottom: -100,
                    child: _Circle(
                      title: title,
                      subtitle: subtitle,
                    ),
                  ),
                  Positioned(
                    left: 30,
                    bottom: 100,
                    child: Row(
                      children: [
                        _Indicator(current: pageIndex == 0),
                        const SizedBox(width: 4),
                        _Indicator(current: pageIndex == 1),
                        const SizedBox(width: 4),
                        _Indicator(current: pageIndex == 2),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 16,
                    bottom: 74,
                    child: _Button(
                      onPressed: onNext,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Circle extends StatelessWidget {
  const _Circle({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 470,
      width: 470,
      padding: const EdgeInsets.symmetric(horizontal: 57),
      decoration: BoxDecoration(
        color: const Color(0xff03456A),
        borderRadius: BorderRadius.circular(235),
      ),
      child: Column(
        children: [
          const SizedBox(height: 70),
          Padding(
            padding: const EdgeInsets.only(left: 70),
            child: Text(
              title,
              style: const TextStyle(
                color: AppColors.main,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontFamily: 'MontserratB',
              ),
            ),
          ),
          const SizedBox(height: 22),
          Padding(
            padding: const EdgeInsets.only(left: 70),
            child: Text(
              subtitle,
              style: const TextStyle(
                color: AppColors.main,
                fontSize: 18,
                fontFamily: 'SF',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({required this.current});

  final bool current;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height: 5,
      width: current ? 22 : 5,
      decoration: BoxDecoration(
        color: current ? const Color(0xff06234C) : const Color(0xff468AA5),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({required this.onPressed});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 190,
      decoration: BoxDecoration(
        color: AppColors.button,
        borderRadius: BorderRadius.circular(16),
      ),
      child: CupertinoButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            const SizedBox(width: 36),
            const Spacer(),
            const Text(
              'Next',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'MontserratM',
              ),
            ),
            const Spacer(),
            SvgPicture.asset('assets/arrow.svg'),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
