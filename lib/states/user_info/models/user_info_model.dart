import 'dart:collection';
import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone_vandad_yt/states/constants/firebase_field_name.dart';

import 'package:instagram_clone_vandad_yt/states/posts/typedefs/user_id.dart';

@immutable
class UserInfoModel extends MapView<String, String> {
  final UserId userId;
  final String email;
  final String displayName;
  UserInfoModel({
    required this.userId,
    required this.email,
    required this.displayName,
  }) : super({
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.displayName: displayName,
          FirebaseFieldName.email: email,
        });

  UserInfoModel.fromJson(
    Map<String, dynamic> json, {
    required UserId userId,
  }) : this(
          userId: userId,
          displayName: json[FirebaseFieldName.displayName] ?? '',
          email: json[FirebaseFieldName.displayName],
        );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoModel &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          displayName == other.displayName &&
          email == other.email;

  @override
  int get hashCode => Object.hashAll(
        [
          userId,
          email,
          displayName,
        ],
      );
}
