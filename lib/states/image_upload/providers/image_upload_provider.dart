import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/image_upload/notifiers/image_upload_notifier.dart';
import 'package:instagram_clone_vandad_yt/states/image_upload/typedef/is_loading.dart';

final imageUploadProvider =
    StateNotifierProvider<ImageUploadNotifier, IsLoading>(
  (_) => ImageUploadNotifier(),
);
