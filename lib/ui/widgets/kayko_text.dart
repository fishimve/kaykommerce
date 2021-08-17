import 'package:flutter/material.dart';
import 'package:kaykommerce/ui/shared/app_colors.dart';
import 'package:kaykommerce/ui/shared/styles.dart';

class KaykoText extends StatelessWidget {
  final String text;
  final TextStyle style;
  const KaykoText.headingOne(this.text) : style = heading1Style;
  const KaykoText.headingTwo(this.text) : style = heading2Style;
  const KaykoText.headingThree(this.text) : style = heading3Style;
  const KaykoText.headline(this.text) : style = headlineStyle;
  const KaykoText.subheading(this.text) : style = subHeadingStyle;
  const KaykoText.caption(this.text) : style = captionStyle;

  KaykoText.body(this.text, {Color color = kcMediumGreyColor})
      : style = bodyStyle.copyWith(color: color);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}
