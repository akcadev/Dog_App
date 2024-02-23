import 'package:dog_app/bloc/splash/splash_event.dart';
import 'package:dog_app/bloc/splash/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitialState()) {
    on<StartCacheProcessEvent>((event, emit) async {
      emit(SplashLoadingState());
    });
    on<FinishCacheProcessEvent>((event, emit) async {
      emit(SplashLoadedState());
    });
  }
}
