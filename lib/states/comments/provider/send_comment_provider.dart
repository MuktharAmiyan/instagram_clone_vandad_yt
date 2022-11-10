import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/comments/notifiers/send_comment_notifier.dart';

final sendCommentProvider = StateNotifierProvider<SendCommentNotifier, bool>(
  (_) => SendCommentNotifier(),
);
