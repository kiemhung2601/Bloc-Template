import 'package:flutter/foundation.dart';

class IsolateUtils {
  IsolateUtils._();

  /// A function that spawns an isolate and runs the provided `callback` on that
  /// isolate, passes it the provided `message`, and (eventually) returns the
  /// value returned by `callback`.
  ///
  /// ```dart
  /// Future<int> fibonacci(int value) {
  ///   return IsolateUtils.executeFunction(_fibonacci, value);
  /// }
  ///
  /// int _fibonacci(int n) {
  ///   var a = n - 1;
  ///   var b = n - 2;
  ///   if (n == 1) {
  ///     return 0;
  ///   } else if (n == 0) {
  ///     return 1;
  ///   } else {
  ///     return (_fibonacci(a) + _fibonacci(b));
  ///   }
  /// }
  /// ```
  ///
  ///  * `Q` is the type of the message that kicks off the computation.
  ///  * `R` is the type of the value returned.
  static ComputeImpl get executeFunction => compute;
}
