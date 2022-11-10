import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone_vandad_yt/views/components/constants/strings.dart';
import 'package:instagram_clone_vandad_yt/views/components/dialog/alert_dialog_model.dart';

@immutable
class DeleteDialog extends AlertDialogModel<bool> {
  DeleteDialog({
    required String titleOfObject,
  }) : super(
          title: '${Strings.delete} $titleOfObject',
          buttons: {
            Strings.cancel: false,
            Strings.delete: true,
          },
          message: "${Strings.areYouSureYouWantToDeleteThis} $titleOfObject",
        );
}
