// main.dart
import 'package:final_timebrew_app/data/datasources/timer_database.dart';
import 'package:final_timebrew_app/presentation/blocs/bloc/audio_bloc.dart';
import 'package:final_timebrew_app/presentation/blocs/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_timebrew_app/domain/usecases/start_timer.dart';
import 'package:final_timebrew_app/presentation/blocs/bloc/timer_bloc.dart';
import 'package:final_timebrew_app/presentation/pages/splashpage.dart';
import 'package:final_timebrew_app/data/repositories/timer_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

// import 'package:hive_flutter/hive_flutter.dart';

// Future<void> main() async {
//   await Hive.initFlutter();
//   await TimerDatabase.init();
//   runApp(CoffeeTimerApp());
// }

// class CoffeeTimerApp extends StatelessWidget {
//   final StartTimer startTimerUseCase = StartTimer(TimerRepository());

//   CoffeeTimerApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<ThemeBloc>(
//       create: (context) => ThemeBloc(),
//       child: BlocBuilder<ThemeBloc, ThemeState>(
//         builder: (context, themeState) {
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             title: 'Coffee Timer',
//             theme: themeState.themeData,
//             home: BlocProvider(
//               create: (context) =>
//                   TimerBloc(startTimerUseCase: startTimerUseCase),
//               child: SplashPage(),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

Future<void> main() async {
  await Hive.initFlutter();
  await TimerDatabase.init();
  runApp(CoffeeTimerApp());
}

class CoffeeTimerApp extends StatelessWidget {
  final StartTimer startTimerUseCase = StartTimer(TimerRepository());
  CoffeeTimerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Provide ThemeBloc
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        // Provide AudioBloc
        BlocProvider<AudioBloc>(
          create: (context) => AudioBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Coffee Timer',
              theme: themeState.themeData,
              home: BlocProvider(
                create: (context) =>
                    TimerBloc(startTimerUseCase: startTimerUseCase),
                child: SplashPage(),
              ));
        },
      ),
    );
  }
}
