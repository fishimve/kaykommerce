import 'package:flutter/material.dart';
import 'package:kaykommerce/ui/shared/app_colors.dart';
import 'package:kaykommerce/ui/widgets/kayko_text.dart';

class KaykoButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const KaykoButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kcPrimaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: KaykoText.body(
          title,
          color: Colors.white,
        ),
      ),
    );
  }
}
