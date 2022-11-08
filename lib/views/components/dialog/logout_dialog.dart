import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone_vandad_yt/views/components/constants/strings.dart';
import 'package:instagram_clone_vandad_yt/views/components/dialog/alert_dialog_model.dart';

@immutable
class LogOutDialog extends AlertDialogModel<bool> {
  const LogOutDialog()
      : super(
          title: Strings.logOut,
          message: Strings.areYouSureThatYouWantToLogOutOfTheApp,
          buttons: const {
            Strings.cancel: false,
            Strings.logOut: true,
          },
        );
}
