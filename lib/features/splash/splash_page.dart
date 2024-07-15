import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/config/app_colors.dart';
import '../../core/utils.dart';
import '../../core/widgets/custom_scaffold.dart';
import '../transaction/bloc/transaction_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void load() async {
    context.read<TransactionBloc>().add(GetTransactionsEvent());
    await getData().then((value) {
      Future.delayed(const Duration(seconds: 2), () {
        if (onboard) {
          context.go('/onboard');
        } else {
          context.go('/home');
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(flex: 2),
            Container(
              height: 256,
              width: 256,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white),
                image: const DecorationImage(
                  image: AssetImage('assets/splash.png'),
                ),
              ),
            ),
            const Spacer(),
            const CircularProgressIndicator(
              color: AppColors.main,
              strokeWidth: 7,
              strokeAlign: 2,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
