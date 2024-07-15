import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';

class BigButton extends StatelessWidget {
  const BigButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 146,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 38),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        gradient: const LinearGradient(
          colors: [
            Color(0xff4960F9),
            Color(0xff1433FF),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(0.1),
            blurRadius: 50,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              bottom: -20,
              right: -30,
              child: Container(
                height: 132,
                width: 132,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(66),
                  color: Colors.redAccent,
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff5264F9),
                      Color(0xff3AF9EF),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: -40,
              right: -10,
              child: Container(
                height: 132,
                width: 132,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(66),
                  color: Colors.redAccent,
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xffC72FF8),
                      const Color(0xffC630F8).withOpacity(0),
                    ],
                  ),
                ),
              ),
            ),
            CupertinoButton(
              onPressed: () {
                context.read<HomeBloc>().add(ChangePageEvent(index: 1));
              },
              padding: EdgeInsets.zero,
              child: const Row(
                children: [
                  SizedBox(width: 32),
                  Text(
                    'Add a new\ntransaction',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: 28),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
