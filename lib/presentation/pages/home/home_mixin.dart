import 'package:dog_app/business_logic/primary/primary_bloc.dart';
import 'package:dog_app/presentation/pages/home/home.dart';
import 'package:dog_app/utils/image_cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin HomeMixin on State<HomePage> {
  late PrimaryBloc primaryBloc;

  final TextEditingController textController = TextEditingController();
  late final ImageCacheManager imageCacheManager;

  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    imageCacheManager = ImageCacheManager();
    primaryBloc = BlocProvider.of<PrimaryBloc>(context);
  }
}
