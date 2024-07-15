import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class PlusMinusButton extends StatelessWidget {
  const PlusMinusButton({super.key, required this.plus});

  final bool plus;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        context.push('/plusminus', extra: plus);
      },
      padding: EdgeInsets.zero,
      child: SvgPicture.asset(
        plus ? 'assets/plusbutton.svg' : 'assets/minusbutton.svg',
        height: 100,
      ),
    );
  }
}
