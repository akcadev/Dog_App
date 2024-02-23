class PrimaryState {
  final int? tabIndex;
  final bool? bottomSheetIsopen;

  const PrimaryState({this.tabIndex = 0, this.bottomSheetIsopen = false});

  PrimaryState copyWith({int? tabIndex, bool? bottomSheetIsopen}) {
    return PrimaryState(
        tabIndex: tabIndex ?? this.tabIndex,
        bottomSheetIsopen: bottomSheetIsopen ?? this.bottomSheetIsopen);
  }
}