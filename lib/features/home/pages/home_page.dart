import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/custom_scaffold.dart';
import '../../../core/widgets/page_title_card.dart';
import '../../add/pages/add_page.dart';
import '../../box/pages/box_page.dart';
import '../../transaction/pages/transactions_page.dart';
import '../bloc/home_bloc.dart';
import '../widgets/big_button.dart';
import '../widgets/balance_card.dart';
import '../widgets/nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Stack(
        children: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeAdd) return const AddPage();

              if (state is HomeTransactions) return const TransactionsPage();

              if (state is HomeMoneyBox) return const BoxPage();

              return const _Home();
            },
          ),
          const NavBar(),
        ],
      ),
    );
  }
}

class _Home extends StatefulWidget {
  const _Home();

  @override
  State<_Home> createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        PageTitleCard(
          title: 'Homepage',
          height: 230,
        ),
        Column(
          children: [
            SizedBox(height: 160),
            BalanceCard(),
            SizedBox(height: 50),
            BigButton(),
          ],
        ),
      ],
    );
  }
}
