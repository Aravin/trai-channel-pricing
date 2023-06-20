import 'package:channel_pricing/shared/constants.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: kSecondaryColor,
      height: 20,
      thickness: 2.5,
      indent: 20,
      endIndent: 20,
    );
  }
}
