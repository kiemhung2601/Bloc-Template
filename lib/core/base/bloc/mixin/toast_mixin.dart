import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';

import '../../../../data/network/network_exception.dart';

// import '../../../../data/network/network_exception.dart';

mixin ToastMixin on Object {
  Future<bool?> addToastMessage(String message) => Fluttertoast.showToast(
        msg: message,
        fontSize: 12,
        backgroundColor: const Color(0xFF000000).withOpacity(0.8),
      );

  Future<bool?> addToastException(Exception exception) {
    if (exception is NetworkException) {
      return addToastMessage(exception.message ?? exception.toString());
    }

    return addToastMessage(exception.toString());
  }
}
