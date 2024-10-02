import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'stopwatch_cubit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Color bgcolor = const Color(0xFFF6F8FE);
  Color secondry = const Color(0xFFECEFF9);
  Color highlight = const Color(0xFFE7EBF7);
  List<dynamic> LapsList = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StopwatchCubit(),
      child: Scaffold(
        backgroundColor: bgcolor,
        appBar: AppBar(
            leading: const Padding(
              padding: EdgeInsets.only(left: 25, top: 20),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 30,
              ),
            ),
            title: Center(
                child: Padding(
              padding: const EdgeInsets.only(top: 15, right: 55, bottom: 5),
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                    color: secondry, borderRadius: BorderRadius.circular(360)),
                child: const Center(
                  child: Text(
                    'StopWatch',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ))),
        body: BlocBuilder<StopwatchCubit, StopwatchState>(
          builder: (context, state) {
            String formattedTime = timeFormat(state);
            if (state is StopwatchRunning) {
              LapsList = state.elapsedTime.inMilliseconds > 0 ? LapsList : [];
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 110),
                  child: Center(
                      child: InkWell(
                    onTap: () {
                      if (state is StopwatchRunning) {
                        LapsList.add({
                          'lap': 'LAP ${LapsList.length + 1}',
                          'time': formattedTime,
                        });
                        context.read<StopwatchCubit>().laps(LapsList);
                      }
                    },
                    child: Container(
                        height: 270,
                        width: 270,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(360),
                            boxShadow: List.filled(10,
                                BoxShadow(color: highlight, blurRadius: 30))),
                        child: Center(
                          child: Text(
                            formattedTime,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 40,
                                fontFamily: 'Redex'),
                          ),
                        )),
                  )),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: ListView.builder(
                    itemCount: LapsList.length,
                    scrollDirection: Axis.horizontal,
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 80),
                    itemBuilder: (context, index) {
                      final lapsItem = LapsList[index];
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 30, left: 10, right: 5),
                        child: Container(
                          height: 120,
                          width: 180,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15), // Menambahkan padding kiri
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment
                                  .center, // Menempatkan konten di tengah secara vertikal
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Menempatkan konten di kiri secara horizontal
                              children: [
                                Text(
                                  lapsItem['lap'],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Redex',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    lapsItem['time'],
                                    style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontFamily: 'Ubuntu',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: InkWell(
                            onTap: () {
                              if (state is StopwatchRunning) {
                                context.read<StopwatchCubit>().pause();
                              } else {
                                context.read<StopwatchCubit>().start();
                              }
                            },
                            child: Container(
                              height: 70,
                              width: 160,
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(360),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    state is StopwatchRunning
                                        ? Icons.pause_rounded
                                        : Icons.play_arrow_rounded,
                                    color: Colors.grey.shade300,
                                    size: 35,
                                  ),
                                  Container(
                                    width: 10,
                                  ),
                                  Text(
                                    state is StopwatchRunning
                                        ? 'PAUSE'
                                        : state is StopwatchPaused
                                            ? 'RESUME'
                                            : 'START',
                                    style: TextStyle(
                                      color: Colors.grey.shade300,
                                      fontSize: 19,
                                      fontFamily: 'Ubuntu',
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                      const Spacer(),
                      Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: InkWell(
                            onTap: () {
                              if (state is StopwatchRunning) {
                                context.read<StopwatchCubit>().stop();
                              } else {
                                context.read<StopwatchCubit>().reset();
                              }
                            },
                            child: Container(
                              height: 70,
                              width: 160,
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(360),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    state is StopwatchRunning
                                        ? Icons.stop_rounded
                                        : Icons.refresh_rounded,
                                    color: Colors.grey.shade300,
                                    size: 35,
                                  ),
                                  Container(
                                    width: 10,
                                  ),
                                  Text(
                                    state is StopwatchRunning
                                        ? 'STOP'
                                        : 'RESET',
                                    style: TextStyle(
                                      color: Colors.grey.shade300,
                                      fontSize: 19,
                                      fontFamily: 'Ubuntu',
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String timeFormat(StopwatchState state) {
    if (state is StopwatchRunning) {
      return state.elapsedTime.inHours.toString().padLeft(2, '0') +
          ':' +
          (state.elapsedTime.inMinutes % 60).toString().padLeft(2, '0') +
          ':' +
          (state.elapsedTime.inSeconds % 60).toString().padLeft(2, '0') +
          '.' +
          (state.elapsedTime.inMilliseconds % 1000).toString().padLeft(3, '0');
    }
    return '00:00:00.000';
  }
}
