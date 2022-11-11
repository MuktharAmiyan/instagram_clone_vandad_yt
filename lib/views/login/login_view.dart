import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/auth/provider/auth_state_notifier.dart';
import 'package:instagram_clone_vandad_yt/views/constants/app_color.dart';
import 'package:instagram_clone_vandad_yt/views/constants/strings.dart';
import 'package:instagram_clone_vandad_yt/views/login/divider_with_margins.dart';
import 'package:instagram_clone_vandad_yt/views/login/facebook_button.dart';
import 'package:instagram_clone_vandad_yt/views/login/google_buton.dart';
import 'package:instagram_clone_vandad_yt/views/login/login_view_signup_link.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.appName,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Text(
                Strings.welcomeToAppName,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const DividerWithMargins(),
              Text(
                Strings.logIntoYourAccount,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(height: 1.5),
              ),
              const SizedBox(height: 20),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.loginButtonColor,
                  foregroundColor: AppColors.loginButtonTextColor,
                ),
                onPressed: ref.read(authStateProvider.notifier).logInWithGoogle,
                child: const GoogleButton(),
              ),
              const SizedBox(height: 20),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.loginButtonColor,
                  foregroundColor: AppColors.loginButtonTextColor,
                ),
                onPressed:
                    ref.read(authStateProvider.notifier).logInWithFaceBook,
                child: const FacebookButton(),
              ),
              const DividerWithMargins(),
              const LoginViewSignupLink(),
            ],
          ),
        ),
      ),
    );
  }
}
