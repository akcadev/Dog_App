import 'package:dog_app/business_logic/index.dart';
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
