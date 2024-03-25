import 'package:flutter/material.dart';
import 'package:togo_mobile/presentation/resources/resources.dart';

class CommonSwitchButton extends StatelessWidget {
  final bool isOpen;
  final Function(bool) onChanged;
  const CommonSwitchButton(
      {super.key, required this.isOpen, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Sizes.s40,
      height: Sizes.s24,
      child: FittedBox(
        fit: BoxFit.fill,
        child: Switch(
          value: isOpen,
          activeColor: Palette.green,
          inactiveThumbColor: Palette.grey7f7f,
          trackOutlineColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return Palette.green;
            }
            return Palette.grey7f7f;
          }),
          trackColor: MaterialStateProperty.all(Palette.transparent),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          thumbIcon: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return const Icon(Icons.circle,
                  size: Sizes.s16, color: Palette.green);
            }
            return const Icon(Icons.circle,
                size: Sizes.s16, color: Palette.grey7f7f);
          }),
          thumbColor: MaterialStateProperty.all(Palette.transparent),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
