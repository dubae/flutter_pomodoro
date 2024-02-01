import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  int totalSeconds = twentyFiveMinutes;

  ///late 사용하는 좋은 예시.
  late Timer timer;
  bool isRunning = false;
  int totalCount = 0;

  ///매초 실행됨
  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalCount++;
        isRunning = false;
        totalSeconds = twentyFiveMinutes;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds--;
      });
    }
  }

  void onStartPressed() {
    /// 1초(duration)마다 실행되는 함수 ontick.
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    print(duration);
    return duration.toString().substring(2, 7);
  }

  void onRestartPressed() {
    if (!isRunning) {
      setState(() {
        totalSeconds = twentyFiveMinutes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Center(
              child: IconButton(
                color: Theme.of(context).cardColor,
                iconSize: 120,
                onPressed: !isRunning ? onStartPressed : onPausePressed,
                icon: Icon(!isRunning ? Icons.play_circle_outlined : Icons.pause_circle_outline_sharp),
              ),
            ),
          ),
          Flexible(
            child: Center(
              child: IconButton(
                onPressed: onRestartPressed,
                icon: const Icon(Icons.stop_circle_outlined),
                color: Theme.of(context).cardColor,
                iconSize: 100,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                ///Expanded: 베이지색 배경을 끝까지 확장시키도록 함.
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoros',
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).textTheme.displayLarge?.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '$totalCount',
                          style: TextStyle(
                            fontSize: 60,
                            color: Theme.of(context).textTheme.displayLarge?.color,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
