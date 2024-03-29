import 'package:flutter/material.dart';
import 'package:instagram_clone_vandad_yt/views/components/rich_text/base_text.dart';
import 'package:instagram_clone_vandad_yt/views/components/rich_text/rich_text_widget.dart';
import 'package:instagram_clone_vandad_yt/views/constants/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginViewSignupLink extends StatelessWidget {
  const LoginViewSignupLink({super.key});

  @override
  Widget build(BuildContext context) {
    return RichTextWidget(
      texts: [
        BaseText.plain(
          text: Strings.dontHaveAnAccount + Strings.signUpOn,
        ),
        BaseText.link(
            text: Strings.facebook,
            onTapped: () {
              launchUrl(
                Uri.parse(
                  Strings.facebookSignupUrl,
                ),
              );
            }),
        BaseText.plain(
          text: Strings.orCreateAnAccountOn,
        ),
        BaseText.link(
            text: Strings.google,
            onTapped: () {
              launchUrl(
                Uri.parse(
                  Strings.googleSignupUrl,
                ),
              );
            }),
      ],
      styleForAll: Theme.of(context).textTheme.subtitle1?.copyWith(height: 1.5),
    );
  }
}
