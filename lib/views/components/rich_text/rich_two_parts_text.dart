import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instagram_clone_vandad_yt/views/components/rich_text/rich_text_widget.dart';

class RichTwoPart extends StatelessWidget {
  final String leftPart;
  final String rightPart;
  const RichTwoPart({
    super.key,
    required this.leftPart,
    required this.rightPart,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: leftPart,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: ' $rightPart',
          )
        ],
        style: const TextStyle(
          color: Colors.white70,
          height: 1.5,
        ),
      ),
    );
  }
}
