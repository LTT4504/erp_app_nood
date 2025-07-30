import 'package:logger/logger.dart';

final log = Logger(
  printer: PrettyPrinter(
    methodCount: 0, // Ẩn stacktrace nếu không cần
    colors: true,
    printEmojis: true,
    printTime: false,
  ),
);
