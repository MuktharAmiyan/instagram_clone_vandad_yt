import 'package:flutter/animation.dart';
import 'package:instagram_clone_vandad_yt/extensions/string/remove_all.dart';

extension AsHtmlColorToColor on String {
  Color htmlColorToColor() => Color(
        int.parse(
          removeAll(
            ['0x', '#'],
          ).padLeft(8, 'ff'),
          radix: 16,
        ),
      );
}
