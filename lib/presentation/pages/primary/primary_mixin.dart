import 'package:dog_app/business_logic/index.dart';
import 'package:dog_app/presentation/pages/primary/primary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin PrimaryMixin on State<PrimaryPage> {
  late PrimaryBloc primaryBloc;

  @override
  void initState() {
    primaryBloc = BlocProvider.of<PrimaryBloc>(context);
    super.initState();
  }
}
