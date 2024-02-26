import 'package:dog_app/business_logic/index.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class PrimaryEvent {}

class TabChangeEvent extends PrimaryEvent {
  final int tabIndex;

  TabChangeEvent({required this.tabIndex});
}

class BottomSheetEvent extends PrimaryEvent {
  final BottomSizes bottomSheetIsopen;

  BottomSheetEvent({required this.bottomSheetIsopen});
}
