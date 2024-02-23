import 'package:dog_app/api/api_repository.dart';
import 'package:dog_app/bloc/dog/dog_bloc.dart';
import 'package:dog_app/bloc/primary/primary_bloc.dart';
import 'package:dog_app/bloc/splash/splash_bloc.dart';
import 'package:dog_app/routes.dart';
import 'package:dog_app/features/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SplashBloc()),
          BlocProvider(create: (context) => DogBloc(ApiRepository())),
          BlocProvider(create: (context) => PrimaryBloc()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          onGenerateRoute: Routes().generateRoute,
          initialRoute: "/",
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const SplashView(),
        ));
  }
}