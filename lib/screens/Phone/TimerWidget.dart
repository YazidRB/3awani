import 'package:async/async.dart';
import 'package:flutter/widgets.dart';

class TimerWidget extends StatefulWidget {
  final Function() onFinish;
  final TimerController controller;

  const TimerWidget(
      {Key? key, required this.controller, required this.onFinish})
      : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  String _timeText = "02:00";

  void _initTimer() {
    const oneSec = const Duration(seconds: 1);

    widget.controller._timer = new RestartableTimer(oneSec, () {
      Duration counter = widget.controller.counter;
      if (counter.isNegative) {
        widget.onFinish();
        widget.controller._timer!.cancel();
      } else {
        setState(() {
          int minutes = (counter.inSeconds / 60).floor();
          int seconds = counter.inSeconds % 60;
          _timeText = minutes > 9
              ? minutes.toString()
              : "0" +
                  minutes.toString() +
                  ":" +
                  (seconds > 9 ? seconds.toString() : "0" + seconds.toString());
          widget.controller.counter = Duration(seconds: counter.inSeconds - 1);
        });

        widget.controller._timer!.reset();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _initTimer();
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller._timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Text(_timeText);
  }
}

class TimerController {
  RestartableTimer? _timer;
  late Duration counter;
  final Duration duration;

  TimerController({required this.duration}) {
    counter = Duration(seconds: duration.inSeconds);
  }

  void restart() {
    counter = Duration(seconds: duration.inSeconds);
    _timer!.reset();
  }
}
