import 'package:flutter/cupertino.dart';

@immutable
abstract class SplashEvent {}

class StartCacheProcessEvent extends SplashEvent {}

class FinishCacheProcessEvent extends SplashEvent {}
