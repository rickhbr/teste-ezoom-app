import 'package:flutter/material.dart';
import 'package:teste_app/src/components/text/custom_text.dart';
import 'package:teste_app/src/constants/mixins/screen_utils.dart';

class DividerOr extends StatelessWidget with ScreenUtilityMixin {
  const DividerOr({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Container(
          width: width * 0.3,
          height: 1,
          color: Colors.grey.withOpacity(0.5),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: setWidth(12.0)),
          child: Customtext(
            text: 'OU',
            fontSize: setFontSize(14),
            fontWeight: FontWeight.normal,
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
        Container(
          width: width * 0.3,
          height: 1,
          color: Colors.grey.withOpacity(0.5),
        ),
      ],
    );
  }
}
