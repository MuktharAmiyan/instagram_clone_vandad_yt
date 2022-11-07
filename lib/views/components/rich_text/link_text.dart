import 'package:flutter/foundation.dart ' show immutable, VoidCallback;
import 'package:instagram_clone_vandad_yt/views/components/rich_text/base_text.dart';

@immutable
class LinkText extends BaseText {
  final VoidCallback onTap;
  const LinkText({
    required this.onTap,
    required super.text,
    super.style,
  });
}
