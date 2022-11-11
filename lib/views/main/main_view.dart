import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/auth/provider/auth_state_notifier.dart';
import 'package:instagram_clone_vandad_yt/states/image_upload/helpers/image_picker_helper.dart';
import 'package:instagram_clone_vandad_yt/states/image_upload/models/file_type.dart';
import 'package:instagram_clone_vandad_yt/states/post_settings/provider/post_settings_provider.dart';
import 'package:instagram_clone_vandad_yt/views/components/dialog/alert_dialog_model.dart';
import 'package:instagram_clone_vandad_yt/views/components/dialog/logout_dialog.dart';
import 'package:instagram_clone_vandad_yt/views/constants/strings.dart';
import 'package:instagram_clone_vandad_yt/views/create_new_post/create_new_post_view.dart';
import 'package:instagram_clone_vandad_yt/views/tabs/user_posts/user_posts_view.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Strings.appName),
          actions: [
            IconButton(
              onPressed: () async {
                final videoFile = await ImagePickerHelper.pickVideoFromGalley();
                if (videoFile != null) {
                  // ignore: unused_result
                  ref.refresh(postSettingsProvider);
                  if (!mounted) {
                    return;
                  }
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CreateNewPostView(
                          fileToPost: videoFile, fileType: FileType.video),
                    ),
                  );
                }
              },
              icon: const FaIcon(FontAwesomeIcons.film),
            ),
            IconButton(
              onPressed: () async {
                final imageFile =
                    await ImagePickerHelper.pickImageFromGallery();
                if (imageFile != null) {
                  // ignore: unused_result
                  ref.refresh(postSettingsProvider);
                  if (!mounted) {
                    return;
                  }
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CreateNewPostView(
                          fileToPost: imageFile, fileType: FileType.image),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.add_photo_alternate),
            ),
            IconButton(
              onPressed: () async {
                final isShouldLogOut =
                    await const LogOutDialog().present(context).then(
                          (value) => value ?? false,
                        );
                isShouldLogOut
                    ? ref.read(authStateProvider.notifier).logOut()
                    : null;
              },
              icon: const Icon(Icons.logout),
            )
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.person),
              ),
              Tab(
                icon: Icon(Icons.search),
              ),
              Tab(
                icon: Icon(Icons.home),
              ),
            ],
          ),
        ),
        body: const TabBarView(children: [
          UserPostView(),
          UserPostView(),
          UserPostView(),
        ]),
      ),
    );
  }
}
