import 'package:final_timebrew_app/data/repositories/timer_repository.dart';
import 'package:final_timebrew_app/domain/usecases/start_timer.dart';
import 'package:final_timebrew_app/presentation/blocs/bloc/timer_bloc.dart';
import 'package:final_timebrew_app/presentation/pages/settingsPage.dart';
import 'package:final_timebrew_app/presentation/pages/timer_view.dart';
import 'package:final_timebrew_app/presentation/widgets/generic_cup_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// HomePage.dart
import 'package:final_timebrew_app/presentation/pages/timer_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TimerView(),
    );
  }
}


// class HomePage extends StatelessWidget {
//   final StartTimer startTimerUseCase = StartTimer(TimerRepository());

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => TimerBloc(startTimerUseCase: startTimerUseCase),
//       child: Scaffold(
//         body: TimerView(),
//       ),
//     );
//   }
// }




// // 1) When the timer is running it keeps the phone on and the timer still runs in teh background when the app is not selected (like other timer apps)
// // 2) There is a widget that shows on the phone lock screen and if you swipe up on the top of the phone.
// // 3) Timer makes a buzzing sound when it finishes
// // Please change NOTHING else, // Please change NOTHING else, // Please change NOTHING else, // Please change NOTHING else, // Please change NOTHING else, // Please change NOTHING else,
// import 'dart:io';












// import 'package:final_timebrew_app/core/live_activity_service.dart';
// import 'package:final_timebrew_app/data/repositories/timer_repository.dart';
// import 'package:final_timebrew_app/domain/usecases/start_timer.dart';
// import 'package:final_timebrew_app/presentation/blocs/bloc/timer_bloc.dart';
// import 'package:final_timebrew_app/presentation/pages/settingsPage.dart';
// import 'package:final_timebrew_app/presentation/widgets/generic_cup_animation.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// // Import the necessary packages
// import 'package:wakelock/wakelock.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:vibration/vibration.dart';
// import 'dart:async';
// // lib/presentation/pages/homepage.dart

// // lib/presentation/pages/homepage.dart

// class HomePage extends StatelessWidget {
//   final StartTimer startTimerUseCase = StartTimer(TimerRepository());

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => TimerBloc(startTimerUseCase: startTimerUseCase),
//       child: Scaffold(
//         body: TimerView(),
//       ),
//     );
//   }
// }

// class TimerView extends StatefulWidget {
//   @override
//   _TimerViewState createState() => _TimerViewState();
// }

// class _TimerViewState extends State<TimerView>
//     with AutomaticKeepAliveClientMixin {
//   int _selectedMinute = 0;
//   int _selectedSecond = 0;
//   bool _showDigits = true;
//   bool _showButtons = true;
//   bool _hasStarted = false;

//   late PageController _pageController;
//   CupType _currentCup = CupType.Coffee;

//   // Controllers for the time pickers
//   late FixedExtentScrollController _minuteController;
//   late FixedExtentScrollController _secondController;

//   // Track the current page index to maintain cup selection
//   int _currentPage = 999;

//   // Notification plugin
//   FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

//   // TimerBloc state subscription
//   late StreamSubscription<TimerState> _timerSubscription;

//   // Timer for updating Live Activity
//   Timer? _liveActivityTimer;

//   @override
//   void initState() {
//     super.initState();
//     final cupCount = CupType.values.length;
//     _currentPage = (1000 ~/ cupCount) * cupCount + (cupCount - 1);
//     _pageController = PageController(initialPage: _currentPage);

//     // Initialize the controllers with the current selected values
//     _minuteController =
//         FixedExtentScrollController(initialItem: _selectedMinute);
//     _secondController =
//         FixedExtentScrollController(initialItem: _selectedSecond);

//     // Initialize the notification plugin
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//     final initializationSettingsIOS = DarwinInitializationSettings();

//     final initializationSettings = InitializationSettings(
//       iOS: initializationSettingsIOS,
//     );

//     flutterLocalNotificationsPlugin?.initialize(initializationSettings);

//     // Listen to TimerBloc state changes
//     _timerSubscription = context.read<TimerBloc>().stream.listen((state) {
//       if (state is TimerRunInProgress) {
//         Wakelock.enable();
//         _showNotification(state.duration);
//         // Start or update Live Activity
//         _startOrUpdateLiveActivity(state.duration);
//       } else if (state is TimerRunComplete) {
//         Wakelock.disable();
//         Vibration.vibrate(duration: 1000);
//         flutterLocalNotificationsPlugin?.cancel(0);
//         // End Live Activity
//         _endLiveActivity();
//       } else {
//         Wakelock.disable();
//         flutterLocalNotificationsPlugin?.cancel(0);
//         // End Live Activity
//         _endLiveActivity();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();

//     // Dispose the controllers
//     _minuteController.dispose();
//     _secondController.dispose();

//     // Cancel the subscription
//     _timerSubscription.cancel();

//     // Cancel the Live Activity timer
//     _liveActivityTimer?.cancel();

//     super.dispose();
//   }

//   // Implement wantKeepAlive to keep the state alive
//   @override
//   bool get wantKeepAlive => true;

//   CupType _getCupType(int index) {
//     final cups = CupType.values;
//     return cups[index % cups.length];
//   }

//   // Method to get cup sizes based on cup type and state
//   Map<String, double> _getCupSizes(CupType cup, {bool isFinalSize = false}) {
//     if (isFinalSize) {
//       // Final sizes when timer is running
//       if (cup == CupType.Beer) {
//         return {'width': 400.0, 'height': 450.0}; // Beer even taller
//       } else if (cup == CupType.Water || cup == CupType.Nativecup) {
//         return {
//           'width': 400.0,
//           'height': 430.0
//         }; // Water and Nativecup even taller
//       } else {
//         return {'width': 410.0, 'height': 320.0}; // Coffee slightly less tall
//       }
//     } else {
//       // Starting sizes in PageView
//       double cupScale = 0.6; // Smaller starting size
//       if (cup == CupType.Beer) {
//         return {'width': 350.0 * cupScale, 'height': 380.0 * cupScale};
//       } else if (cup == CupType.Water || cup == CupType.Nativecup) {
//         return {'width': 350.0 * cupScale, 'height': 340.0 * cupScale};
//       } else {
//         return {'width': 370.0 * cupScale, 'height': 320.0 * cupScale};
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(
//         context); // Call super.build when using AutomaticKeepAliveClientMixin
//     final theme = Theme.of(context);
//     final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;

//     // Get cup sizes based on current cup and whether the timer has started
//     final cupSizes = _getCupSizes(_currentCup, isFinalSize: _hasStarted);
//     double targetWidth = cupSizes['width']!;
//     double targetHeight = cupSizes['height']!;

//     return Scaffold(
//       body: GestureDetector(
//         behavior: HitTestBehavior.translucent,
//         onTap: () {
//           // Bring back the buttons when the screen is tapped and buttons are hidden
//           if (!_showButtons) {
//             setState(() {
//               _showButtons = true;
//             });
//           }
//         },
//         child: Stack(
//           children: [
//             Center(
//               child: BlocBuilder<TimerBloc, TimerState>(
//                 builder: (context, state) {
//                   Duration duration;
//                   Duration totalDuration;
//                   bool isCompleted = false;

//                   if (state is TimerRunInProgress) {
//                     duration = state.duration;
//                     totalDuration = state.totalDuration;
//                   } else if (state is TimerRunPause) {
//                     duration = state.duration;
//                     totalDuration = state.totalDuration;
//                   } else if (state is TimerRunComplete) {
//                     duration = Duration.zero;
//                     totalDuration = Duration.zero;
//                     isCompleted = true;
//                   } else {
//                     // Use the selected time from the pickers
//                     duration = Duration(
//                         minutes: _selectedMinute, seconds: _selectedSecond);
//                     totalDuration = duration;
//                   }

//                   double fillPercentage = 1.0;
//                   if (totalDuration.inSeconds > 0) {
//                     fillPercentage =
//                         duration.inSeconds / totalDuration.inSeconds;
//                     fillPercentage = fillPercentage.clamp(0.0, 1.0);
//                   }

//                   final minutesStr = duration.inMinutes
//                       .remainder(60)
//                       .toString()
//                       .padLeft(2, '0');
//                   final secondsStr =
//                       (duration.inSeconds % 60).toString().padLeft(2, '0');

//                   return Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // Smooth cup transition from PageView size
//                       AnimatedContainer(
//                         width: targetWidth,
//                         height: targetHeight,
//                         duration: Duration(milliseconds: 600),
//                         curve: Curves.easeInOut,
//                         child: IndexedStack(
//                           index: _hasStarted ? 1 : 0,
//                           children: [
//                             // PageView
//                             SizedBox(
//                               height: 300,
//                               child: PageView.builder(
//                                 key: PageStorageKey('PageView'),
//                                 controller: _pageController,
//                                 onPageChanged: (index) {
//                                   setState(() {
//                                     _currentCup = _getCupType(index);
//                                     _currentPage = index; // Update current page
//                                   });
//                                 },
//                                 itemBuilder: (context, index) {
//                                   CupType cup = _getCupType(index);
//                                   final cupSizes = _getCupSizes(cup);
//                                   Size cupSize = Size(
//                                       cupSizes['width']!, cupSizes['height']!);

//                                   return Center(
//                                     child: GenericCupAnimation(
//                                       cupType: cup,
//                                       fillPercentage: 1.0,
//                                       size: cupSize,
//                                       isCompleted: false,
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                             // Cup during timer
//                             GenericCupAnimation(
//                               key: ValueKey(_currentCup),
//                               cupType: _currentCup,
//                               fillPercentage: fillPercentage,
//                               size: Size(targetWidth, targetHeight),
//                               isCompleted: isCompleted,
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: _showButtons ? 10 : 20),
//                       if (_showDigits)
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             if (_hasStarted)
//                               IconButton(
//                                 icon: Icon(Icons.remove, size: 16),
//                                 onPressed: () {
//                                   context
//                                       .read<TimerBloc>()
//                                       .add(TimerUpdated(addSeconds: false));
//                                 },
//                               ),
//                             TweenAnimationBuilder<double>(
//                               tween: Tween<double>(
//                                 begin: fillPercentage,
//                                 end: fillPercentage,
//                               ),
//                               duration: Duration(milliseconds: 600),
//                               builder: (context, value, child) {
//                                 return Text(
//                                   '$minutesStr:$secondsStr',
//                                   style: TextStyle(
//                                     fontSize: 45,
//                                     fontWeight: FontWeight.bold,
//                                     color: textColor,
//                                   ),
//                                 );
//                               },
//                             ),
//                             if (_hasStarted)
//                               IconButton(
//                                 icon: Icon(Icons.add, size: 16),
//                                 onPressed: () {
//                                   context
//                                       .read<TimerBloc>()
//                                       .add(TimerUpdated(addSeconds: true));
//                                 },
//                               ),
//                           ],
//                         ),
//                       SizedBox(height: 5),
//                       AnimatedContainer(
//                         duration: Duration(milliseconds: 600),
//                         curve: Curves.easeInOut,
//                         height: _hasStarted ? 0 : 150,
//                         child: AnimatedOpacity(
//                           opacity: _hasStarted ? 0.0 : 1.0,
//                           duration: Duration(milliseconds: 600),
//                           curve: Curves.easeInOut,
//                           child: _buildTimePicker(),
//                         ),
//                       ),
//                       AnimatedContainer(
//                         duration: Duration(milliseconds: 600),
//                         curve: Curves.easeInOut,
//                         child: _showButtons
//                             ? _buildControls(context, state)
//                             : null,
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//             // Top buttons with animation
//             Positioned(
//               top: 50,
//               right: 10,
//               child: AnimatedSwitcher(
//                 duration: Duration(milliseconds: 300),
//                 transitionBuilder: (Widget child, Animation<double> animation) {
//                   final offsetAnimation = Tween<Offset>(
//                     begin: Offset(0.5, 0.0), // Start from right
//                     end: Offset(0.0, 0.0), // End at original position
//                   ).animate(animation);
//                   return SlideTransition(
//                     position: offsetAnimation,
//                     child: FadeTransition(
//                       opacity: animation,
//                       child: child,
//                     ),
//                   );
//                 },
//                 child: _showButtons
//                     ? Row(
//                         key: ValueKey('iconsRow'),
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: Icon(
//                               _showButtons
//                                   ? Icons.visibility
//                                   : Icons.visibility_off,
//                               color: theme.iconTheme.color,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _showButtons = !_showButtons;
//                               });
//                             },
//                           ),
//                           IconButton(
//                             icon: Icon(
//                               _showDigits ? Icons.timer : Icons.timer_off,
//                               color: theme.iconTheme.color,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _showDigits = !_showDigits;
//                               });
//                             },
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.settings,
//                                 color: theme.iconTheme.color),
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => SettingsPage()),
//                               );
//                             },
//                           ),
//                         ],
//                       )
//                     : SizedBox.shrink(key: ValueKey('empty')),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Method to show the notification
//   Future<void> _showNotification(Duration duration) async {
//     var iosPlatformChannelSpecifics = DarwinNotificationDetails(
//       presentSound: false,
//       presentAlert: true,
//       presentBadge: false,
//     );

//     var platformChannelSpecifics = NotificationDetails(
//       iOS: iosPlatformChannelSpecifics,
//     );

//     await flutterLocalNotificationsPlugin?.show(
//       0,
//       'Timer Running',
//       'Remaining time: ${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
//       platformChannelSpecifics,
//     );
//   }

//   Widget _buildTimePicker() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Expanded(
//           child: SizedBox(
//             height: 120,
//             child: CupertinoPicker(
//               // Use the persistent controller
//               scrollController: _minuteController,
//               itemExtent: 40,
//               onSelectedItemChanged: (int index) {
//                 setState(() {
//                   _selectedMinute = index;
//                 });
//               },
//               children: List<Widget>.generate(60, (int index) {
//                 return Center(
//                   child: Text(
//                     '${index.toString().padLeft(2, '0')} min',
//                     style: TextStyle(
//                       fontSize: 24,
//                       color: Theme.of(context).textTheme.bodyLarge?.color,
//                     ),
//                   ),
//                 );
//               }),
//             ),
//           ),
//         ),
//         Text(
//           ':',
//           style: TextStyle(
//             fontSize: 30,
//             fontWeight: FontWeight.bold,
//             color: Theme.of(context).textTheme.bodyLarge?.color,
//           ),
//         ),
//         Expanded(
//           child: SizedBox(
//             height: 120,
//             child: CupertinoPicker(
//               // Use the persistent controller
//               scrollController: _secondController,
//               itemExtent: 40,
//               onSelectedItemChanged: (int index) {
//                 setState(() {
//                   _selectedSecond = index;
//                 });
//               },
//               children: List<Widget>.generate(60, (int index) {
//                 return Center(
//                   child: Text(
//                     '${index.toString().padLeft(2, '0')} sec',
//                     style: TextStyle(
//                       fontSize: 24,
//                       color: Theme.of(context).textTheme.bodyLarge?.color,
//                     ),
//                   ),
//                 );
//               }),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildControls(BuildContext context, TimerState state) {
//     Icon mainButtonIcon;
//     VoidCallback mainButtonCallback;

//     if (state is TimerInitial || state is TimerRunComplete) {
//       mainButtonIcon = Icon(Icons.play_arrow);
//       mainButtonCallback = () {
//         setState(() {
//           _hasStarted = true;
//         });
//         Duration duration =
//             Duration(minutes: _selectedMinute, seconds: _selectedSecond);
//         context.read<TimerBloc>().add(
//               TimerStarted(
//                 duration: duration,
//                 totalDuration: duration,
//               ),
//             );

//         // Start Live Activity
//         _startLiveActivity(duration.inSeconds);
//       };
//     } else if (state is TimerRunInProgress) {
//       mainButtonIcon = Icon(Icons.pause);
//       mainButtonCallback = () {
//         context.read<TimerBloc>().add(TimerPaused());
//       };
//     } else if (state is TimerRunPause) {
//       mainButtonIcon = Icon(Icons.play_arrow);
//       mainButtonCallback = () {
//         context.read<TimerBloc>().add(TimerResumed());
//       };
//     } else {
//       mainButtonIcon = Icon(Icons.play_arrow);
//       mainButtonCallback = () {};
//     }

//     final theme = Theme.of(context);

//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             IconButton(
//               icon: mainButtonIcon,
//               iconSize: 40,
//               color: theme.iconTheme.color,
//               onPressed: mainButtonCallback,
//             ),
//             SizedBox(width: 20),
//             IconButton(
//               icon: Icon(Icons.refresh),
//               iconSize: 40,
//               color: theme.iconTheme.color,
//               onPressed: () {
//                 setState(() {
//                   _hasStarted = false; // Unhide the time pickers
//                   // Do not reset _selectedMinute and _selectedSecond
//                   // Do not reset _currentCup, keep the current selection
//                 });
//                 context.read<TimerBloc>().add(TimerReset());
//                 // Ensure the PageView shows the correct page
//                 Future.microtask(() {
//                   if (_pageController.hasClients) {
//                     _pageController.jumpToPage(_currentPage);
//                   }
//                 });

//                 // End Live Activity
//                 _endLiveActivity();
//               },
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   // Live Activity methods
//   void _startLiveActivity(int durationInSeconds) {
//     if (Platform.isIOS) {
//       LiveActivityService.startLiveActivity(
//           durationInSeconds, _currentCup.toString());
//       _liveActivityTimer = Timer.periodic(Duration(seconds: 1), (timer) {
//         if (mounted && _hasStarted) {
//           // Update Live Activity with remaining time
//           final state = context.read<TimerBloc>().state;
//           if (state is TimerRunInProgress) {
//             final remainingTime = state.duration.inSeconds;
//             LiveActivityService.updateLiveActivity(remainingTime);
//           }
//         } else {
//           timer.cancel();
//         }
//       });
//     }
//   }

//   void _startOrUpdateLiveActivity(Duration duration) {
//     if (Platform.isIOS) {
//       // Update Live Activity with remaining time
//       final remainingTime = duration.inSeconds;
//       LiveActivityService.updateLiveActivity(remainingTime);
//     }
//   }

//   void _endLiveActivity() {
//     if (Platform.isIOS) {
//       LiveActivityService.endLiveActivity();
//       _liveActivityTimer?.cancel();
//     }
//   }
// }
