import 'package:flutter/material.dart';
import 'package:togo_mobile/presentation/resources/resources.dart';

class NeverScrollableListView extends StatelessWidget {
  final Widget Function(BuildContext c, int i) itemBuilder;
  final double gap;
  final int count;
  final Axis scrollDirection;
  final double left;
  final double right;

  const NeverScrollableListView(
      {super.key,
      required this.itemBuilder,
      required this.count,
      this.gap = Sizes.s0,
      this.scrollDirection = Axis.vertical,
      this.left = Sizes.s0,
      this.right = Sizes.s0});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(left, Sizes.s0, right, Sizes.s0),
        scrollDirection: scrollDirection,
        itemBuilder: itemBuilder,
        separatorBuilder: (c, i) => SizedBox(
              height: scrollDirection == Axis.vertical ? gap : Sizes.s0,
              width: scrollDirection == Axis.horizontal ? gap : Sizes.s0,
            ),
        itemCount: count);
  }
}
