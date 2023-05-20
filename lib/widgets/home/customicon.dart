import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final Widget icon;
  final String text;
  final GestureTapCallback onPressed;
  final Color background;

  const CustomIcon(
      {super.key,
      required this.icon,
      required this.text,
      required this.onPressed,
      required this.background});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: background,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
            ),
            child: icon,
            // child: const Icon(
            //   Icons.train,
            //   color: AppColor.iconColor,
            //   size: 27,
            // ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(text),
        ],
      ),
    );
  }
}
