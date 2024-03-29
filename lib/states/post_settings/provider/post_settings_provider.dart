import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/post_settings/models/post_settings.dart';
import 'package:instagram_clone_vandad_yt/states/post_settings/notifiers/post_settings_notifier.dart';

final postSettingsProvider =
    StateNotifierProvider<PostSettingsNotifier, Map<PostSettings, bool>>(
  (_) => PostSettingsNotifier(),
);
