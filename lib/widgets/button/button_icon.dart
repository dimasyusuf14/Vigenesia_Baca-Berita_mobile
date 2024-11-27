import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonIcon extends StatelessWidget {
  const ButtonIcon({
    super.key,
    required this.onTap,
    required this.icon, required this.bgcolor, required this.iccolor,
  });
  final VoidCallback onTap;
  final String icon;
  final Color bgcolor;
  final Color iccolor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: bgcolor,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: SvgPicture.asset(
              icon,
              width: 25,
              color: iccolor,
            ),
          ),
        ),
      ),
    );
  }
}
