import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseCollectionName {
  static const users = 'users';
  static const likes = 'likes';
  static const comments = 'comments';
  static const thumbnails = 'thumbnails';
  static const images = 'images';
  static const videos = 'videos';
  static const posts = 'posts';

  const FirebaseCollectionName._();
}
