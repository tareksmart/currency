
import 'package:currencypro/view/constant/myConstants.dart';
import 'package:currencypro/view/widget/text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';


class DigitalWidget extends StatelessWidget {
  const DigitalWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.count(
        childAspectRatio: 2,
        crossAxisSpacing: .5,
        crossAxisCount: 3,
        children: List.generate(
          12,
          (index) => AnimationConfiguration.staggeredGrid(
            position: 10,
            duration: const Duration(seconds: 1),
            columnCount: 3,
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: MyColors.whiteColor),
                  child: MyTextButton(
                    index: index,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
