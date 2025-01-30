import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_stars_app/blocs/github/github_bloc.dart';
import 'package:github_stars_app/blocs/github/github_event.dart';
import 'package:github_stars_app/blocs/ticker/ticker_bloc.dart';
import 'package:github_stars_app/blocs/ticker/ticker_event.dart';
import 'package:github_stars_app/core/apiService.dart';
import 'package:github_stars_app/core/databaseHelper.dart';
import 'package:github_stars_app/core/firebaseService.dart';
import 'package:github_stars_app/core/gitRepo.dart';
import 'package:github_stars_app/core/tickerRepo.dart';
import 'package:github_stars_app/firebase_options.dart';
import 'package:github_stars_app/screens/main_page.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission();
  runApp(const MainApp());
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    print("Executing task: $task");
    return Future.value(true); // Indicate success
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Github Bloc
        BlocProvider(
          create: (context) => GithubBloc(
            GithubRepository(NetworkService(), DatabaseHelper()),
          )..add(FetchRepositories()),
        ),
        BlocProvider(
          create: (context) =>
              TicketBloc(TicketRepository(DatabaseHelper(), FirebaseService()))
                ..add(FetchTickets()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ReopDetailsScreen(),
      ),
    );
  }
}
