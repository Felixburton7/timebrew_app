// // Import the necessary packages for the app, including core functionalities,
// // repository, use cases, and UI elements.
// import 'package:final_timebrew_app/data/repositories/timer_repository.dart';
// import 'package:final_timebrew_app/domain/usecases/start_timer.dart';
// import 'package:final_timebrew_app/presentation/blocs/bloc/timer_bloc.dart';
// import 'package:final_timebrew_app/presentation/pages/settingsPage.dart';
// import 'package:final_timebrew_app/presentation/widgets/full_water_cup_animation.dart';
// import 'package:final_timebrew_app/presentation/widgets/generic_cup_animation.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'dart:math';

// // Define TimerView, which is a StatefulWidget that displays and manages
// // the timer UI and its state.
// class TimerView extends StatefulWidget {
//   @override
//   _TimerViewState createState() => _TimerViewState();
// }

// // Define the state class for TimerView.
// class _TimerViewState extends State<TimerView>
//     with AutomaticKeepAliveClientMixin {
//   // Variables to hold selected timer values (minutes and seconds).
//   int _selectedMinute = 0;
//   int _selectedSecond = 0;
//   // Flags to manage visibility of digits and buttons.
//   bool _showDigits = true;
//   bool _showButtons = true;
//   // Flag to check if the timer has started.
//   bool _hasStarted = false;

//   // Flag to ensure the dialog is shown only once per completion.
//   bool _isDialogShown = false;

//   // PageController to handle cup page transitions.
//   late PageController _pageController;
//   // Default cup type is set to Coffee.
//   CupType _currentCup = CupType.Coffee;

//   // Controllers for the time pickers, set with default selected values.
//   late FixedExtentScrollController _minuteController;
//   late FixedExtentScrollController _secondController;

//   // Track the current page index for PageView.
//   int _currentPage = 999;

//   // Instance of TimerBloc
//   late TimerBloc _timerBloc;

//   // Store fillPercentage as a state variable
//   double _fillPercentage = 1.0;

//   // GlobalKey to access FullWidthWaterCupState
//   final GlobalKey<FullWidthWaterCupState> _fullWidthWaterCupKey =
//       GlobalKey<FullWidthWaterCupState>();

//   @override
//   void initState() {
//     super.initState();
//     // Initialize TimerBloc with required dependencies.
//     _timerBloc = TimerBloc(
//       startTimerUseCase: StartTimer(
//         TimerRepository(),
//       ),
//     );

//     // Set initial page to ensure correct cup alignment in PageView.
//     final cupCount = CupType.values.length;
//     _currentPage = (1000 ~/ cupCount) * cupCount + (cupCount - 1);
//     _pageController = PageController(initialPage: _currentPage);

//     // Initialize controllers for time pickers.
//     _minuteController =
//         FixedExtentScrollController(initialItem: _selectedMinute);
//     _secondController =
//         FixedExtentScrollController(initialItem: _selectedSecond);
//   }

//   @override
//   void dispose() {
//     // Clean up PageController and time pickers to free resources.
//     _pageController.dispose();
//     _minuteController.dispose();
//     _secondController.dispose();
//     // Dispose the TimerBloc to free resources.
//     _timerBloc.close();
//     super.dispose();
//   }

//   // Keep widget's state alive across navigation.
//   @override
//   bool get wantKeepAlive => true;

//   // Method to show the Stop Alarm popup dialog.
//   void _showStopAlarmDialog(BuildContext parentContext) {
//     showDialog(
//       context: parentContext,
//       barrierDismissible:
//           false, // Prevent dismissal by tapping outside the dialog.
//       barrierColor: Colors.black54, // Semi-transparent black background.
//       builder: (BuildContext context) {
//         return Center(
//           child: Container(
//             width: 100,
//             height: 100,
//             decoration: BoxDecoration(
//               color: Colors.black87,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: IconButton(
//               icon: Icon(Icons.stop, color: Colors.white, size: 40),
//               onPressed: () {
//                 // Dispatch TimerReset to stop the alarm and reset the timer.
//                 parentContext.read<TimerBloc>().add(TimerReset());
//                 // Dismiss the dialog.
//                 Navigator.of(context).pop();
//                 // Reset the dialog shown flag.
//                 setState(() {
//                   _isDialogShown = false;
//                   _hasStarted = false; // Reset the timer state
//                 });
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // Helper method to determine the CupType based on index, cycling through available types.
//   CupType _getCupType(int index) {
//     final cups = CupType.values;
//     return cups[index % cups.length];
//   }

//   // Method to set cup size based on its type and state (whether the timer is running).
//   Map<String, double> _getCupSizes(CupType cup, {bool isFinalSize = false}) {
//     if (cup == CupType.FullScreenWater) {
//       // Sizes for the square box when not started
//       return {'width': 150.0, 'height': 150.0};
//     }

//     if (isFinalSize) {
//       // Return final sizes for each cup type when the timer is running.
//       if (cup == CupType.Beer) {
//         return {'width': 400.0, 'height': 450.0};
//       } else if (cup == CupType.Water || cup == CupType.Nativecup) {
//         return {'width': 410.0, 'height': 445.0};
//       } else {
//         return {'width': 420.0, 'height': 330.0};
//       }
//     } else {
//       // Return starting sizes for each cup type in the PageView.
//       double cupScale = 0.6;
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
//         context); // Maintain widget's state using AutomaticKeepAliveClientMixin

//     return BlocProvider<TimerBloc>.value(
//       value: _timerBloc,
//       child: Builder(
//         builder: (context) {
//           final theme = Theme.of(context);
//           final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;

//           return Scaffold(
//             // Add GestureDetector to handle tap events.
//             body: GestureDetector(
//               behavior: HitTestBehavior.translucent,
//               onTapDown: (TapDownDetails details) {
//                 final RenderBox box = context.findRenderObject() as RenderBox;
//                 final Offset localPosition =
//                     box.globalToLocal(details.globalPosition);
//                 final Size size = box.size;
//                 final double screenHeight = size.height;
//                 final double tapY = localPosition.dy;

//                 // Calculate liquid top position
//                 double liquidTop = screenHeight; // Default to bottom of screen
//                 if (_currentCup == CupType.FullScreenWater && _hasStarted) {
//                   liquidTop = screenHeight * (1 - _fillPercentage);
//                 }

//                 if (!_showButtons) {
//                   // If buttons are hidden, show them regardless of tap position
//                   setState(() {
//                     _showButtons = true;
//                   });
//                 } else if (_currentCup == CupType.FullScreenWater &&
//                     _hasStarted &&
//                     tapY >= liquidTop) {
//                   // If buttons are shown and tap is in water area, increase wave frequency
//                   _fullWidthWaterCupKey.currentState?.increaseWaveFrequency();
//                 }
//               },
//               child: Stack(
//                 children: [
//                   // Add the FullWidthWaterCup as background when appropriate
//                   BlocBuilder<TimerBloc, TimerState>(
//                     builder: (context, state) {
//                       // Initialize duration variables based on TimerState.
//                       Duration duration;
//                       Duration totalDuration;

//                       if (state is TimerRunInProgress) {
//                         duration = state.duration;
//                         totalDuration = state.totalDuration;
//                       } else if (state is TimerRunPause) {
//                         duration = state.duration;
//                         totalDuration = state.totalDuration;
//                       } else if (state is TimerRunComplete) {
//                         duration = Duration.zero;
//                         totalDuration = Duration.zero;
//                       } else {
//                         duration = Duration(
//                             minutes: _selectedMinute, seconds: _selectedSecond);
//                         totalDuration = duration;
//                       }

//                       // Calculate fill percentage for animation.
//                       double fillPercentage = 1.0;
//                       if (totalDuration.inSeconds > 0) {
//                         fillPercentage =
//                             duration.inSeconds / totalDuration.inSeconds;
//                         fillPercentage = fillPercentage.clamp(0.0, 1.0);
//                       }
//                       _fillPercentage =
//                           fillPercentage; // Store in state variable

//                       if (_currentCup == CupType.FullScreenWater &&
//                           _hasStarted) {
//                         return Positioned.fill(
//                           child: FullWidthWaterCup(
//                             key: _fullWidthWaterCupKey,
//                             fillPercentage: _fillPercentage,
//                             size: MediaQuery.of(context).size,
//                           ),
//                         );
//                       } else {
//                         return SizedBox.shrink();
//                       }
//                     },
//                   ),
//                   Center(
//                     // Use BlocConsumer to listen to TimerBloc and build UI based on the current state.
//                     child: BlocConsumer<TimerBloc, TimerState>(
//                       listener: (context, state) {
//                         // Show popup dialog if timer is completed and dialog hasn't been shown yet.
//                         if (state is TimerRunComplete && !_isDialogShown) {
//                           _isDialogShown = true;
//                           _showStopAlarmDialog(context);
//                         }
//                       },
//                       builder: (context, state) {
//                         // Initialize duration variables based on TimerState.
//                         Duration duration;
//                         Duration totalDuration;
//                         bool isCompleted = false;

//                         if (state is TimerRunInProgress) {
//                           duration = state.duration;
//                           totalDuration = state.totalDuration;
//                         } else if (state is TimerRunPause) {
//                           duration = state.duration;
//                           totalDuration = state.totalDuration;
//                         } else if (state is TimerRunComplete) {
//                           duration = Duration.zero;
//                           totalDuration = Duration.zero;
//                           isCompleted = true;
//                         } else {
//                           // Set duration based on picker selections if timer is idle.
//                           duration = Duration(
//                               minutes: _selectedMinute,
//                               seconds: _selectedSecond);
//                           totalDuration = duration;
//                         }

//                         // Calculate fill percentage for animation.
//                         double fillPercentage = 1.0;
//                         if (totalDuration.inSeconds > 0) {
//                           fillPercentage =
//                               duration.inSeconds / totalDuration.inSeconds;
//                           fillPercentage = fillPercentage.clamp(0.0, 1.0);
//                         }
//                         _fillPercentage =
//                             fillPercentage; // Update state variable

//                         // Format time display.
//                         final minutesStr = duration.inMinutes
//                             .remainder(60)
//                             .toString()
//                             .padLeft(2, '0');
//                         final secondsStr = (duration.inSeconds % 60)
//                             .toString()
//                             .padLeft(2, '0');

//                         // Set cup size based on the current cup type and timer state.
//                         final cupSizes =
//                             _getCupSizes(_currentCup, isFinalSize: _hasStarted);
//                         double targetWidth = cupSizes['width']!;
//                         double targetHeight = cupSizes['height']!;

//                         // Construct column to display cup animation and timer.
//                         return Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             // For FullScreenWater, we don't display the cup animation here when the timer has started
//                             if (!(_currentCup == CupType.FullScreenWater &&
//                                 _hasStarted))
//                               // Animated container for smooth cup transitions.
//                               AnimatedContainer(
//                                 width: targetWidth,
//                                 height: targetHeight,
//                                 duration: Duration(milliseconds: 600),
//                                 curve: Curves.easeInOut,
//                                 child: IndexedStack(
//                                   index: _hasStarted ? 1 : 0,
//                                   children: [
//                                     // PageView to allow cup type selection.
//                                     SizedBox(
//                                       height: 300,
//                                       child: PageView.builder(
//                                         key: PageStorageKey('PageView'),
//                                         controller: _pageController,
//                                         onPageChanged: (index) {
//                                           setState(() {
//                                             _currentCup = _getCupType(index);
//                                             _currentPage = index;
//                                           });
//                                         },
//                                         itemBuilder: (context, index) {
//                                           CupType cup = _getCupType(index);
//                                           if (cup == CupType.FullScreenWater) {
//                                             final size = Size(150, 150);
//                                             return Center(
//                                               child: Container(
//                                                 decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                     color: theme
//                                                         .colorScheme.primary,
//                                                     width: 2,
//                                                   ),
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                 ),
//                                                 child: IgnorePointer(
//                                                   child: FullWidthWaterCup(
//                                                     fillPercentage: 1.0,
//                                                     size: size,
//                                                   ),
//                                                 ),
//                                               ),
//                                             );
//                                           } else {
//                                             final cupSizes = _getCupSizes(cup);
//                                             Size cupSize = Size(
//                                                 cupSizes['width']!,
//                                                 cupSizes['height']!);

//                                             return Center(
//                                               // Display GenericCupAnimation with selected cup type and size.
//                                               child: GenericCupAnimation(
//                                                 cupType: cup,
//                                                 fillPercentage: 1.0,
//                                                 size: cupSize,
//                                                 isCompleted: false,
//                                               ),
//                                             );
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                     // Display cup animation during timer.
//                                     if (_currentCup != CupType.FullScreenWater)
//                                       GenericCupAnimation(
//                                         key: ValueKey(_currentCup),
//                                         cupType: _currentCup,
//                                         fillPercentage: fillPercentage,
//                                         size: Size(targetWidth, targetHeight),
//                                         isCompleted: isCompleted,
//                                       ),
//                                   ],
//                                 ),
//                               ),
//                             SizedBox(height: _showButtons ? 10 : 20),
//                             if (_showDigits)
//                               // Display timer digits with options to adjust during countdown.
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   if (_hasStarted)
//                                     IconButton(
//                                       icon: Icon(Icons.remove, size: 16),
//                                       onPressed: () {
//                                         context.read<TimerBloc>().add(
//                                             TimerUpdated(addSeconds: false));
//                                       },
//                                     ),
//                                   TweenAnimationBuilder<double>(
//                                     tween: Tween<double>(
//                                         begin: fillPercentage,
//                                         end: fillPercentage),
//                                     duration: Duration(milliseconds: 600),
//                                     builder: (context, value, child) {
//                                       return Text(
//                                         '$minutesStr:$secondsStr',
//                                         style: TextStyle(
//                                           fontSize: 45,
//                                           fontWeight: FontWeight.bold,
//                                           color: textColor,
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                   if (_hasStarted)
//                                     IconButton(
//                                       icon: Icon(Icons.add, size: 16),
//                                       onPressed: () {
//                                         context.read<TimerBloc>().add(
//                                             TimerUpdated(addSeconds: true));
//                                       },
//                                     ),
//                                 ],
//                               ),
//                             SizedBox(height: 5),
//                             // Display time picker when timer is idle.
//                             AnimatedContainer(
//                               duration: Duration(milliseconds: 600),
//                               curve: Curves.easeInOut,
//                               height: _hasStarted ? 0 : 150,
//                               child: AnimatedOpacity(
//                                 opacity: _hasStarted ? 0.0 : 1.0,
//                                 duration: Duration(milliseconds: 600),
//                                 curve: Curves.easeInOut,
//                                 child: _buildTimePicker(),
//                               ),
//                             ),
//                             // Display timer controls.
//                             AnimatedContainer(
//                               duration: Duration(milliseconds: 600),
//                               curve: Curves.easeInOut,
//                               child: _showButtons
//                                   ? _buildControls(context, state)
//                                   : null,
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                   // Position top control buttons with animations for toggling visibility and opening settings.
//                   Positioned(
//                     top: 50,
//                     right: 10,
//                     child: AnimatedSwitcher(
//                       duration: Duration(milliseconds: 300),
//                       transitionBuilder:
//                           (Widget child, Animation<double> animation) {
//                         final offsetAnimation = Tween<Offset>(
//                           begin: Offset(0.5, 0.0),
//                           end: Offset(0.0, 0.0),
//                         ).animate(animation);
//                         return SlideTransition(
//                           position: offsetAnimation,
//                           child: FadeTransition(
//                             opacity: animation,
//                             child: child,
//                           ),
//                         );
//                       },
//                       child: _showButtons
//                           ? Row(
//                               key: ValueKey('iconsRow'),
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 // Toggle visibility of buttons.
//                                 IconButton(
//                                   icon: Icon(
//                                       _showButtons
//                                           ? Icons.visibility
//                                           : Icons.visibility_off,
//                                       color: theme.iconTheme.color),
//                                   onPressed: () {
//                                     setState(() {
//                                       _showButtons = !_showButtons;
//                                     });
//                                   },
//                                 ),
//                                 // Toggle display of timer digits.
//                                 IconButton(
//                                   icon: Icon(
//                                       _showDigits
//                                           ? Icons.timer
//                                           : Icons.timer_off,
//                                       color: theme.iconTheme.color),
//                                   onPressed: () {
//                                     setState(() {
//                                       _showDigits = !_showDigits;
//                                     });
//                                   },
//                                 ),
//                                 // Navigate to SettingsPage.
//                                 IconButton(
//                                   icon: Icon(Icons.settings,
//                                       color: theme.iconTheme.color),
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => SettingsPage()),
//                                     );
//                                   },
//                                 ),
//                               ],
//                             )
//                           : SizedBox.shrink(key: ValueKey('empty')),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // Method to create the time picker UI.
//   Widget _buildTimePicker() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Expanded(
//           child: SizedBox(
//             height: 120,
//             child: CupertinoPicker(
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

//   // Define controls for managing the timer (play, pause, reset).
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
//         DateTime targetEndTime = DateTime.now().add(duration);

//         // Start timer with the selected duration.
//         context.read<TimerBloc>().add(
//               TimerStarted(
//                 duration: duration,
//                 totalDuration: duration,
//                 targetEndTime: targetEndTime,
//               ),
//             );
//       };
//     } else if (state is TimerRunInProgress) {
//       mainButtonIcon = Icon(Icons.pause);
//       mainButtonCallback = () {
//         // Pause timer.
//         context.read<TimerBloc>().add(TimerPaused());
//       };
//     } else if (state is TimerRunPause) {
//       mainButtonIcon = Icon(Icons.play_arrow);
//       mainButtonCallback = () {
//         // Resume timer.
//         context.read<TimerBloc>().add(TimerResumed());
//       };
//     } else {
//       mainButtonIcon = Icon(Icons.play_arrow);
//       mainButtonCallback = () {};
//     }

//     final theme = Theme.of(context);

//     // Display main control buttons.
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
//                 // Reset timer and refresh view with current selection.
//                 setState(() {
//                   _hasStarted = false;
//                 });
//                 context.read<TimerBloc>().add(TimerReset());
//                 Future.microtask(() {
//                   if (_pageController.hasClients) {
//                     _pageController.jumpToPage(_currentPage);
//                   }
//                 });
//               },
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
// lib/presentation/pages/timer_view.dart

// Import the necessary packages for the app, including core functionalities,
// repository, use cases, and UI elements.
import 'package:final_timebrew_app/data/repositories/timer_repository.dart';
import 'package:final_timebrew_app/domain/usecases/start_timer.dart';
import 'package:final_timebrew_app/presentation/blocs/bloc/timer_bloc.dart';
import 'package:final_timebrew_app/presentation/blocs/bloc/audio_bloc.dart'; // Import AudioBloc
import 'package:final_timebrew_app/presentation/pages/settingsPage.dart';
import 'package:final_timebrew_app/presentation/widgets/full_water_cup_animation.dart';
import 'package:final_timebrew_app/presentation/widgets/generic_cup_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

// Define TimerView, which is a StatefulWidget that displays and manages
// the timer UI and its state.
class TimerView extends StatefulWidget {
  @override
  _TimerViewState createState() => _TimerViewState();
}

// Define the state class for TimerView.
class _TimerViewState extends State<TimerView>
    with AutomaticKeepAliveClientMixin {
  // Variables to hold selected timer values (minutes and seconds).
  int _selectedMinute = 0;
  int _selectedSecond = 0;
  // Flags to manage visibility of digits and buttons.
  bool _showDigits = true;
  bool _showButtons = true;
  // Flag to check if the timer has started.
  bool _hasStarted = false;

  // Flag to ensure the dialog is shown only once per completion.
  bool _isDialogShown = false;

  // PageController to handle cup page transitions.
  late PageController _pageController;
  // Default cup type is set to Coffee.
  CupType _currentCup = CupType.Coffee;

  // Controllers for the time pickers, set with default selected values.
  late FixedExtentScrollController _minuteController;
  late FixedExtentScrollController _secondController;

  // Track the current page index for PageView.
  int _currentPage = 999;

  // Instance of TimerBloc
  late TimerBloc _timerBloc;

  // Store fillPercentage as a state variable
  double _fillPercentage = 1.0;

  // GlobalKey to access FullWidthWaterCupState
  final GlobalKey<FullWidthWaterCupState> _fullWidthWaterCupKey =
      GlobalKey<FullWidthWaterCupState>();

  @override
  void initState() {
    super.initState();
    // Initialize TimerBloc with required dependencies.
    _timerBloc = TimerBloc(
      startTimerUseCase: StartTimer(
        TimerRepository(),
      ),
    );

    // Set initial page to ensure correct cup alignment in PageView.
    final cupCount = CupType.values.length;
    _currentPage = (1000 ~/ cupCount) * cupCount + (cupCount - 1);
    _pageController = PageController(initialPage: _currentPage);

    // Initialize controllers for time pickers.
    _minuteController =
        FixedExtentScrollController(initialItem: _selectedMinute);
    _secondController =
        FixedExtentScrollController(initialItem: _selectedSecond);
  }

  @override
  void dispose() {
    // Clean up PageController and time pickers to free resources.
    _pageController.dispose();
    _minuteController.dispose();
    _secondController.dispose();
    // Dispose the TimerBloc to free resources.
    _timerBloc.close();
    super.dispose();
  }

  // Keep widget's state alive across navigation.
  @override
  bool get wantKeepAlive => true;

  // Method to show the Stop Alarm popup dialog.
  void _showStopAlarmDialog(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      barrierDismissible:
          false, // Prevent dismissal by tapping outside the dialog.
      barrierColor: Colors.black54, // Semi-transparent black background.
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              icon: Icon(Icons.stop, color: Colors.white, size: 40),
              onPressed: () {
                // Dispatch TimerReset to stop the alarm and reset the timer.
                parentContext.read<TimerBloc>().add(TimerReset());
                // Dismiss the dialog.
                Navigator.of(context).pop();
                // Reset the dialog shown flag.
                setState(() {
                  _isDialogShown = false;
                  _hasStarted = false; // Reset the timer state
                });
              },
            ),
          ),
        );
      },
    );
  }

  // Helper method to determine the CupType based on index, cycling through available types.
  CupType _getCupType(int index) {
    final cups = CupType.values;
    return cups[index % cups.length];
  }

  // Method to set cup size based on its type and state (whether the timer is running).
  Map<String, double> _getCupSizes(CupType cup, {bool isFinalSize = false}) {
    if (cup == CupType.FullScreenWater) {
      // Sizes for the square box when not started
      return {'width': 150.0, 'height': 150.0};
    }

    if (isFinalSize) {
      // Return final sizes for each cup type when the timer is running.
      if (cup == CupType.Beer) {
        return {'width': 400.0, 'height': 450.0};
      } else if (cup == CupType.Water || cup == CupType.Nativecup) {
        return {'width': 410.0, 'height': 445.0};
      } else {
        return {'width': 420.0, 'height': 330.0};
      }
    } else {
      // Return starting sizes for each cup type in the PageView.
      double cupScale = 0.6;
      if (cup == CupType.Beer) {
        return {'width': 350.0 * cupScale, 'height': 380.0 * cupScale};
      } else if (cup == CupType.Water || cup == CupType.Nativecup) {
        return {'width': 350.0 * cupScale, 'height': 340.0 * cupScale};
      } else {
        return {'width': 370.0 * cupScale, 'height': 320.0 * cupScale};
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(
        context); // Maintain widget's state using AutomaticKeepAliveClientMixin

    return MultiBlocProvider(
      providers: [
        BlocProvider<TimerBloc>.value(
          value: _timerBloc,
        ),
        // Ensure AudioBloc is accessible
      ],
      child: Builder(
        builder: (context) {
          final theme = Theme.of(context);
          final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;

          return Scaffold(
            // Add GestureDetector to handle tap events.
            body: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTapDown: (TapDownDetails details) {
                final RenderBox box = context.findRenderObject() as RenderBox;
                final Offset localPosition =
                    box.globalToLocal(details.globalPosition);
                final Size size = box.size;
                final double screenHeight = size.height;
                final double tapY = localPosition.dy;

                // Calculate liquid top position
                double liquidTop = screenHeight; // Default to bottom of screen
                if (_currentCup == CupType.FullScreenWater && _hasStarted) {
                  liquidTop = screenHeight * (1 - _fillPercentage);
                }

                if (!_showButtons) {
                  // If buttons are hidden, show them regardless of tap position
                  setState(() {
                    _showButtons = true;
                  });
                } else if (_currentCup == CupType.FullScreenWater &&
                    _hasStarted &&
                    tapY >= liquidTop) {
                  // If buttons are shown and tap is in water area, increase wave frequency
                  _fullWidthWaterCupKey.currentState?.increaseWaveFrequency();
                }
              },
              child: Stack(
                children: [
                  // Add the FullWidthWaterCup as background when appropriate
                  BlocBuilder<TimerBloc, TimerState>(
                    builder: (context, state) {
                      // Initialize duration variables based on TimerState.
                      Duration duration;
                      Duration totalDuration;

                      if (state is TimerRunInProgress) {
                        duration = state.duration;
                        totalDuration = state.totalDuration;
                      } else if (state is TimerRunPause) {
                        duration = state.duration;
                        totalDuration = state.totalDuration;
                      } else if (state is TimerRunComplete) {
                        duration = Duration.zero;
                        totalDuration = Duration.zero;
                      } else {
                        duration = Duration(
                            minutes: _selectedMinute, seconds: _selectedSecond);
                        totalDuration = duration;
                      }

                      // Calculate fill percentage for animation.
                      double fillPercentage = 1.0;
                      if (totalDuration.inSeconds > 0) {
                        fillPercentage =
                            duration.inSeconds / totalDuration.inSeconds;
                        fillPercentage = fillPercentage.clamp(0.0, 1.0);
                      }
                      _fillPercentage =
                          fillPercentage; // Store in state variable

                      if (_currentCup == CupType.FullScreenWater &&
                          _hasStarted) {
                        return Positioned.fill(
                          child: FullWidthWaterCup(
                            key: _fullWidthWaterCupKey,
                            fillPercentage: _fillPercentage,
                            size: MediaQuery.of(context).size,
                          ),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                  Center(
                    // Use BlocConsumer to listen to TimerBloc and build UI based on the current state.
                    child: BlocConsumer<TimerBloc, TimerState>(
                      listener: (context, state) {
                        // Show popup dialog if timer is completed and dialog hasn't been shown yet.
                        if (state is TimerRunComplete && !_isDialogShown) {
                          _isDialogShown = true;
                          _showStopAlarmDialog(context);
                        }
                      },
                      builder: (context, state) {
                        // Initialize duration variables based on TimerState.
                        Duration duration;
                        Duration totalDuration;
                        bool isCompleted = false;

                        if (state is TimerRunInProgress) {
                          duration = state.duration;
                          totalDuration = state.totalDuration;
                        } else if (state is TimerRunPause) {
                          duration = state.duration;
                          totalDuration = state.totalDuration;
                        } else if (state is TimerRunComplete) {
                          duration = Duration.zero;
                          totalDuration = Duration.zero;
                          isCompleted = true;
                        } else {
                          // Set duration based on picker selections if timer is idle.
                          duration = Duration(
                              minutes: _selectedMinute,
                              seconds: _selectedSecond);
                          totalDuration = duration;
                        }

                        // Calculate fill percentage for animation.
                        double fillPercentage = 1.0;
                        if (totalDuration.inSeconds > 0) {
                          fillPercentage =
                              duration.inSeconds / totalDuration.inSeconds;
                          fillPercentage = fillPercentage.clamp(0.0, 1.0);
                        }
                        _fillPercentage =
                            fillPercentage; // Update state variable

                        // Format time display.
                        final minutesStr = duration.inMinutes
                            .remainder(60)
                            .toString()
                            .padLeft(2, '0');
                        final secondsStr = (duration.inSeconds % 60)
                            .toString()
                            .padLeft(2, '0');

                        // Set cup size based on the current cup type and timer state.
                        final cupSizes =
                            _getCupSizes(_currentCup, isFinalSize: _hasStarted);
                        double targetWidth = cupSizes['width']!;
                        double targetHeight = cupSizes['height']!;

                        // Construct column to display cup animation and timer.
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // For FullScreenWater, we don't display the cup animation here when the timer has started
                            if (!(_currentCup == CupType.FullScreenWater &&
                                _hasStarted))
                              // Animated container for smooth cup transitions.
                              AnimatedContainer(
                                width: targetWidth,
                                height: targetHeight,
                                duration: Duration(milliseconds: 600),
                                curve: Curves.easeInOut,
                                child: IndexedStack(
                                  index: _hasStarted ? 1 : 0,
                                  children: [
                                    // PageView to allow cup type selection.
                                    SizedBox(
                                      height: 300,
                                      child: PageView.builder(
                                        key: PageStorageKey('PageView'),
                                        controller: _pageController,
                                        onPageChanged: (index) {
                                          setState(() {
                                            _currentCup = _getCupType(index);
                                            _currentPage = index;
                                          });
                                        },
                                        itemBuilder: (context, index) {
                                          CupType cup = _getCupType(index);
                                          if (cup == CupType.FullScreenWater) {
                                            final size = Size(150, 150);
                                            return Center(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: theme
                                                        .colorScheme.primary,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: IgnorePointer(
                                                  child: FullWidthWaterCup(
                                                    fillPercentage: 1.0,
                                                    size: size,
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else {
                                            final cupSizes = _getCupSizes(cup);
                                            Size cupSize = Size(
                                                cupSizes['width']!,
                                                cupSizes['height']!);

                                            return Center(
                                              // Display GenericCupAnimation with selected cup type and size.
                                              child: GenericCupAnimation(
                                                cupType: cup,
                                                fillPercentage: 1.0,
                                                size: cupSize,
                                                isCompleted: false,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                    // Display cup animation during timer.
                                    if (_currentCup != CupType.FullScreenWater)
                                      GenericCupAnimation(
                                        key: ValueKey(_currentCup),
                                        cupType: _currentCup,
                                        fillPercentage: fillPercentage,
                                        size: Size(targetWidth, targetHeight),
                                        isCompleted: isCompleted,
                                      ),
                                  ],
                                ),
                              ),
                            SizedBox(height: _showButtons ? 10 : 20),
                            if (_showDigits)
                              // Display timer digits with options to adjust during countdown.
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (_hasStarted)
                                    IconButton(
                                      icon: Icon(Icons.remove, size: 16),
                                      onPressed: () {
                                        context.read<TimerBloc>().add(
                                            TimerUpdated(addSeconds: false));
                                      },
                                    ),
                                  TweenAnimationBuilder<double>(
                                    tween: Tween<double>(
                                        begin: fillPercentage,
                                        end: fillPercentage),
                                    duration: Duration(milliseconds: 600),
                                    builder: (context, value, child) {
                                      return Text(
                                        '$minutesStr:$secondsStr',
                                        style: TextStyle(
                                          fontSize: 45,
                                          fontWeight: FontWeight.bold,
                                          color: textColor,
                                        ),
                                      );
                                    },
                                  ),
                                  if (_hasStarted)
                                    IconButton(
                                      icon: Icon(Icons.add, size: 16),
                                      onPressed: () {
                                        context.read<TimerBloc>().add(
                                            TimerUpdated(addSeconds: true));
                                      },
                                    ),
                                ],
                              ),
                            SizedBox(height: 5),
                            // Display time picker when timer is idle.
                            AnimatedContainer(
                              duration: Duration(milliseconds: 600),
                              curve: Curves.easeInOut,
                              height: _hasStarted ? 0 : 150,
                              child: AnimatedOpacity(
                                opacity: _hasStarted ? 0.0 : 1.0,
                                duration: Duration(milliseconds: 600),
                                curve: Curves.easeInOut,
                                child: _buildTimePicker(),
                              ),
                            ),
                            // Display timer controls.
                            AnimatedContainer(
                              duration: Duration(milliseconds: 600),
                              curve: Curves.easeInOut,
                              child: _showButtons
                                  ? _buildControls(context, state)
                                  : null,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  // Position top control buttons with animations for toggling visibility and opening settings.
                  Positioned(
                    top: 50,
                    right: 10,
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        final offsetAnimation = Tween<Offset>(
                          begin: Offset(0.5, 0.0),
                          end: Offset(0.0, 0.0),
                        ).animate(animation);
                        return SlideTransition(
                          position: offsetAnimation,
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                      child: _showButtons
                          ? Row(
                              key: ValueKey('iconsRow'),
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Toggle visibility of buttons.
                                IconButton(
                                  icon: Icon(
                                      _showButtons
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: theme.iconTheme.color),
                                  onPressed: () {
                                    setState(() {
                                      _showButtons = !_showButtons;
                                    });
                                  },
                                ),
                                // Toggle display of timer digits.
                                IconButton(
                                  icon: Icon(
                                      _showDigits
                                          ? Icons.timer
                                          : Icons.timer_off,
                                      color: theme.iconTheme.color),
                                  onPressed: () {
                                    setState(() {
                                      _showDigits = !_showDigits;
                                    });
                                  },
                                ),
                                // Navigate to SettingsPage.
                                IconButton(
                                  icon: Icon(Icons.settings,
                                      color: theme.iconTheme.color),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SettingsPage()),
                                    );
                                  },
                                ),
                              ],
                            )
                          : SizedBox.shrink(key: ValueKey('empty')),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Method to create the time picker UI.
  Widget _buildTimePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            height: 120,
            child: CupertinoPicker(
              scrollController: _minuteController,
              itemExtent: 40,
              onSelectedItemChanged: (int index) {
                setState(() {
                  _selectedMinute = index;
                });
              },
              children: List<Widget>.generate(60, (int index) {
                return Center(
                  child: Text(
                    '${index.toString().padLeft(2, '0')} min',
                    style: TextStyle(
                      fontSize: 24,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        Text(
          ':',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 120,
            child: CupertinoPicker(
              scrollController: _secondController,
              itemExtent: 40,
              onSelectedItemChanged: (int index) {
                setState(() {
                  _selectedSecond = index;
                });
              },
              children: List<Widget>.generate(60, (int index) {
                return Center(
                  child: Text(
                    '${index.toString().padLeft(2, '0')} sec',
                    style: TextStyle(
                      fontSize: 24,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  // Define controls for managing the timer (play, pause, reset).
  Widget _buildControls(BuildContext context, TimerState state) {
    Icon mainButtonIcon;
    VoidCallback mainButtonCallback;

    if (state is TimerInitial || state is TimerRunComplete) {
      mainButtonIcon = Icon(Icons.play_arrow);
      mainButtonCallback = () {
        setState(() {
          _hasStarted = true;
        });
        Duration duration =
            Duration(minutes: _selectedMinute, seconds: _selectedSecond);
        DateTime targetEndTime = DateTime.now().add(duration);

        // Access the AudioBloc
        final audioBloc = context.read<AudioBloc>();
        final audioAssetPath = audioBloc.state.audioData.audioAssetPath;

        print('Selected Audio Asset Path: $audioAssetPath'); // Debug print

        // Start timer with the selected duration and audio asset path.
        context.read<TimerBloc>().add(
              TimerStarted(
                duration: duration,
                totalDuration: duration,
                targetEndTime: targetEndTime,
                audioAssetPath: audioAssetPath, // Pass the audio asset path
              ),
            );
      };
    } else if (state is TimerRunInProgress) {
      mainButtonIcon = Icon(Icons.pause);
      mainButtonCallback = () {
        // Pause timer.
        context.read<TimerBloc>().add(TimerPaused());
      };
    } else if (state is TimerRunPause) {
      mainButtonIcon = Icon(Icons.play_arrow);
      mainButtonCallback = () {
        // Resume timer.
        context.read<TimerBloc>().add(TimerResumed());
      };
    } else {
      mainButtonIcon = Icon(Icons.play_arrow);
      mainButtonCallback = () {};
    }

    final theme = Theme.of(context);

    // Display main control buttons.
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: mainButtonIcon,
              iconSize: 40,
              color: theme.iconTheme.color,
              onPressed: mainButtonCallback,
            ),
            SizedBox(width: 20),
            IconButton(
              icon: Icon(Icons.refresh),
              iconSize: 40,
              color: theme.iconTheme.color,
              onPressed: () {
                // Reset timer and refresh view with current selection.
                setState(() {
                  _hasStarted = false;
                });
                context.read<TimerBloc>().add(TimerReset());
                Future.microtask(() {
                  if (_pageController.hasClients) {
                    _pageController.jumpToPage(_currentPage);
                  }
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
