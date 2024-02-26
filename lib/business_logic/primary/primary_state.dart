enum BottomSizes { closed, minSize, maxSize }

class PrimaryState {
  final int? tabIndex;
  final BottomSizes? bottomSheetIsopen;

  const PrimaryState({this.tabIndex = 0, this.bottomSheetIsopen = BottomSizes.closed});

  PrimaryState copyWith({int? tabIndex, BottomSizes? bottomSheetIsopen}) {
    return PrimaryState(
        tabIndex: tabIndex ?? this.tabIndex,
        bottomSheetIsopen: bottomSheetIsopen ?? this.bottomSheetIsopen);
  }
}
