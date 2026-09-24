import 'package:get/get.dart';

/// Returns the controller of type [T], creating it the first time a screen
/// asks for it.
///
/// This is how controllers get created here — directly where they are needed,
/// with no bindings. Calling it again on a rebuild returns the same instance,
/// so the screen's state survives; `Get.put` on its own would replace it.
T useController<T>(T Function() create) =>
    Get.isRegistered<T>() ? Get.find<T>() : Get.put<T>(create());

/// Groups thousands the way every figure in the design is written: `486,320`.
String groupThousands(int value) {
  final s = value.abs().toString();
  final b = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) b.write(',');
    b.write(s[i]);
  }
  return b.toString();
}

/// `Rs 12,000`
String rupees(int value) => 'Rs ${groupThousands(value)}';

/// `0:56` from a number of seconds.
String countdown(int seconds) {
  final m = seconds ~/ 60;
  final s = (seconds % 60).toString().padLeft(2, '0');
  return '$m:$s';
}

/// `05/09/2026` from a date.
String formatDate(DateTime d) =>
    '${d.day.toString().padLeft(2, '0')}/'
    '${d.month.toString().padLeft(2, '0')}/${d.year}';
