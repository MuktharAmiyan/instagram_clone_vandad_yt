import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/post_settings/models/post_settings.dart';

class PostSettingsNotifier extends StateNotifier<Map<PostSettings, bool>> {
  PostSettingsNotifier()
      : super(
          UnmodifiableMapView(
            {
              for (final settings in PostSettings.values) settings: true,
            },
          ),
        );

  void setSettings(
    PostSettings postSettings,
    bool value,
  ) {
    final existingValue = state[postSettings];
    if (existingValue == null || existingValue == value) {
      return;
    }
    state = Map.unmodifiable(
      Map.from(state)..[postSettings] = value,
    );
  }
}
