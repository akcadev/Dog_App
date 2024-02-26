import 'package:dog_app/api/api_repository.dart';
import 'package:dog_app/business_logic/dog/dog_bloc.dart';
import 'package:dog_app/business_logic/primary/primary_bloc.dart';
import 'package:dog_app/routes.dart';
import 'package:dog_app/presentation/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => DogBloc(ApiRepository())),
          BlocProvider(create: (context) => PrimaryBloc()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Routes().generateRoute,
          initialRoute: "/",
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              bottomSheetTheme: BottomSheetThemeData(
                  backgroundColor: Colors.transparent.withOpacity(0),
                  elevation: 0)),
          home: const SplashView(),
        ));
  }
}
