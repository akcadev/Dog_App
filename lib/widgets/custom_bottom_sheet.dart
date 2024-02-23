import 'package:dog_app/bloc/primary/primary_bloc.dart';
import 'package:dog_app/bloc/primary/primary_event.dart';
import 'package:dog_app/bloc/primary/primary_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    required PrimaryBloc primaryBloc,
    required this.focusNode,
    required this.textController,
  }) : _primaryBloc = primaryBloc;

  final PrimaryBloc _primaryBloc;
  final FocusNode focusNode;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onVerticalDragUpdate: (details) {
      if (details.delta.dy > 20 && details.delta.direction > 1) {
        if (MediaQuery.of(context).viewInsets.bottom == 0) {
          _primaryBloc.add(BottomSheetEvent(bottomSheetIsopen: false));
          FocusManager.instance.primaryFocus?.unfocus();
        }
      }
      if (details.delta.dy > -20 && details.delta.direction < -1) {
        _primaryBloc.add(BottomSheetEvent(bottomSheetIsopen: true));
        focusNode.requestFocus();
      }
    }, child: BlocBuilder<PrimaryBloc, PrimaryState>(
      builder: (context, statePrimary) {
        return AnimatedContainer(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.only(left: 10, top: 10),
          duration: const Duration(milliseconds: 300),
          width: MediaQuery.of(context).size.width - 33,
          height: statePrimary.bottomSheetIsopen! ? 500 : 70,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xffE5E5EA), width: 2)),
          child: TextField(
            controller: textController,
            focusNode: focusNode,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration.collapsed(hintText: 'Search'),
          ),
        );
      },
    ));
  }
}
