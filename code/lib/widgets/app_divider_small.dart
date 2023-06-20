import 'package:channel_pricing/shared/constants.dart';
import 'package:flutter/material.dart';

class CustomDividerSmall extends StatelessWidget {
  const CustomDividerSmall({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: kSecondaryColor,
      height: 5,
      thickness: 2,
      indent: 20,
      endIndent: 20,
    );
  }
}
