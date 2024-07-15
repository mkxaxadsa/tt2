import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/utils.dart';

class TargetField extends StatefulWidget {
  const TargetField({super.key});

  @override
  State<TargetField> createState() => _TargetFieldState();
}

class _TargetFieldState extends State<TargetField> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  bool readOnly = true;

  @override
  void initState() {
    super.initState();
    controller.text = boxTarget;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 64,
          margin: const EdgeInsets.symmetric(horizontal: 58),
          decoration: BoxDecoration(
            color: const Color(0xff87F0FF).withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  readOnly: readOnly,
                  textCapitalization: TextCapitalization.sentences,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                  decoration: const InputDecoration(
                    hintText: '...',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                  onTapOutside: (event) async {
                    await saveTarget(controller.text);
                    setState(() {
                      readOnly = true;
                    });
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  onSubmitted: (value) async {
                    await saveTarget(value);
                    setState(() {
                      readOnly = true;
                    });
                  },
                ),
              ),
              // Container(
              //   height: 1,
              //   margin: const EdgeInsets.symmetric(horizontal: 25),
              //   color: readOnly ? Colors.transparent : Colors.white,
              // ),
              // const SizedBox(height: 4),
            ],
          ),
        ),
        readOnly
            ? Positioned(
                right: 24 + 58,
                top: 0,
                bottom: 0,
                child: CupertinoButton(
                  onPressed: () {
                    setState(() {
                      readOnly = false;
                    });
                    FocusScope.of(context).requestFocus(focusNode);
                    controller.selection = TextSelection.fromPosition(
                      TextPosition(offset: controller.text.length),
                    );
                  },
                  minSize: 24,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: SvgPicture.asset('assets/edit.svg'),
                ),
              )
            : Container(),
      ],
    );
  }
}
