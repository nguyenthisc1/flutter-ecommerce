import 'package:ecommerce/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TChoiceChip extends StatelessWidget {
  const TChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onPressed,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onPressed;

  @override
  Widget build(BuildContext context) {
    final isColor = THelperFunctions.getColor(text);
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColor != null ? const SizedBox() : Text(text),
        selected: selected,
        onSelected: onPressed,
        labelStyle: TextStyle(color: selected ? TColors.white : null),
        avatar: isColor != null
            ? TCircularContainer(
                width: 50,
                height: 50,
                backgroundColor: THelperFunctions.getColor(text)!,
              )
            : null,
        labelPadding: isColor != null ? const EdgeInsets.all(0) : null,
        padding: isColor != null ? const EdgeInsets.all(0) : null,
        selectedColor: isColor != null ? Colors.green : null,
        shape: isColor != null ? const CircleBorder() : null,
      ),
    );
  }
}
