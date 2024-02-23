import 'package:dog_app/bloc/dog/dog_bloc.dart';
import 'package:dog_app/bloc/dog/dog_event.dart';
import 'package:dog_app/bloc/dog/dog_state.dart';
import 'package:dog_app/bloc/splash/splash_bloc.dart';
import 'package:dog_app/bloc/splash/splash_event.dart';
import 'package:dog_app/bloc/splash/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SplashBloc>(context).add(StartCacheProcessEvent());

    return Scaffold(
      body: MultiBlocListener(listeners: [
        BlocListener<DogBloc, DogState>(
          listener: (context, state) {
            if (state is StateBreedsFetched) {
              BlocProvider.of<SplashBloc>(context)
                  .add(FinishCacheProcessEvent());
            }
          },
        ),
        BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is SplashInitialState) {
            } else if (state is SplashLoadingState) {
              BlocProvider.of<DogBloc>(context).add(FetchBreedsEvent());
            } else if (state is SplashLoadedState) {
              Navigator.of(context).pushReplacementNamed('/primary');
            }
          },
        ),
      ], child: Center(child: Image.asset("assets/dog-app.png"))),
    );
  }
}
