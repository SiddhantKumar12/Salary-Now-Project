import 'dart:ui';
import 'package:logger/logger.dart';
import 'package:salarynow/utils/color.dart';

final logger = (Type type) => Logger(
      printer: CustomPrinter(type.toString()),
      level: Level.verbose,
    );

class CustomPrinter extends LogPrinter {
  final String className;
  CustomPrinter(this.className);

  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.levelColors[event.level];
    final emoji = PrettyPrinter.levelEmojis[event.level];
    final message = event.message;

    return [color!('$emoji $className: $message')];
  }
}

// class MyLogger extends Logger {
//   MyLogger({
//     Level level = Level.debug,
//     LogFilter? filter,
//     LogOutput? output,
//     int? bufferSize,
//     bool? printer,
//     bool colors = true,
//     bool? printTime,
//   }) : super(
//           level: level,
//           filter: filter,
//           output: output,
//         );
//
//   @override
//   Color getColor(Level level) {
//     switch (level) {
//       case Level.verbose:
//         return MyColor.subtitleTextColor.withOpacity(0.5);
//       case Level.debug:
//         return MyColor.blueColor;
//       case Level.info:
//         return MyColor.greenColor;
//       case Level.warning:
//         return MyColor.amberColor;
//       case Level.error:
//         return MyColor.amberColor;
//       case Level.wtf:
//         return MyColor.purpleColor;
//       default:
//         return MyColor.whiteColor;
//     }
//   }
//
//   void logCustom(Level level, var message) {
//     log(level, message);
//     // additional custom logic here
//   }
// }
