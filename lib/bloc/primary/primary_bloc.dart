import 'package:dog_app/bloc/primary/primary_event.dart';
import 'package:dog_app/bloc/primary/primary_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrimaryBloc extends Bloc<PrimaryEvent, PrimaryState> {
  PrimaryBloc() : super(const PrimaryState()) {
    on<TabChangeEvent>(setTabIndex);
    on<BottomSheetEvent>(setBottomSheet);
  }

  void setTabIndex(TabChangeEvent event, emit) {
    emit(state.copyWith(tabIndex: event.tabIndex));
  }

  void setBottomSheet(BottomSheetEvent event, emit) {
    emit(state.copyWith(bottomSheetIsopen: event.bottomSheetIsopen));
  }
}
