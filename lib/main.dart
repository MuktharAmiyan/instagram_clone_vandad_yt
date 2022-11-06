import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/firebase_options.dart';
import 'package:instagram_clone_vandad_yt/states/auth/provider/auth_state_notifier.dart';
import 'package:instagram_clone_vandad_yt/states/auth/provider/is_logged_in_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        indicatorColor: Colors.blueGrey,
        primarySwatch: Colors.blueGrey,
      ),
      themeMode: ThemeMode.dark,
      home: Consumer(
        builder: (_, ref, child) {
          final isLoggedIn = ref.watch(isLoggedInProvider);
          if (isLoggedIn) {
            return const MainView();
          } else {
            return const LoginView();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            TextButton(
              onPressed: ref.read(authStateProvider.notifier).logInWithFaceBook,
              child: const Text("Facebbok"),
            ),
            TextButton(
              onPressed: ref.read(authStateProvider.notifier).logInWithGoogle,
              child: const Text("Google"),
            )
          ],
        ));
  }
}

class MainView extends ConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextButton(
            onPressed: ref.read(authStateProvider.notifier).logOut,
            child: const Text("LogOut"),
          ),
        ],
      ),
    );
  }
}
