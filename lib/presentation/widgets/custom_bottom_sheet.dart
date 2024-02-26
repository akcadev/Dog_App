import 'package:dog_app/business_logic/index.dart';
import 'package:dog_app/models/breeds_response.dart';
import 'package:dog_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet(
      {super.key,
      required PrimaryBloc primaryBloc,
      required this.focusNode,
      required this.textController,
      required this.breedsList})
      : _primaryBloc = primaryBloc;

  final PrimaryBloc _primaryBloc;
  final FocusNode focusNode;
  final TextEditingController textController;
  final BreedsList breedsList;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PrimaryBloc, PrimaryState>(
      builder: (context, statePrimary) {
        return Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.5),
                blurRadius: 3,
                spreadRadius: 2)
          ], borderRadius: BorderRadius.circular(10)),
          child: TextField(
            keyboardType: TextInputType.none,
            showCursor: false,
            autofocus: false,
            readOnly: true,
            controller: textController,
            onTap: () {
              _openSheet(BottomSizes.closed);
            },
            maxLines: 1,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Search',
                contentPadding: EdgeInsets.all(20)),
          ),
        );
      },
      listenWhen: (previous, current) {
        if (current.bottomSheetIsopen == BottomSizes.maxSize) {
          return true;
        } else if (current.bottomSheetIsopen == BottomSizes.closed) {
          return true;
        } else if (previous.bottomSheetIsopen == BottomSizes.maxSize) {
          return false;
        } else if (previous.bottomSheetIsopen == BottomSizes.closed) {
          return true;
        }
        return true;
      },
      listener: (BuildContext context, PrimaryState state) async {
        if (state.bottomSheetIsopen! == BottomSizes.minSize) {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useRootNavigator: true,
            showDragHandle: true,
            useSafeArea: true,
            enableDrag: false,
            isDismissible: false,
            backgroundColor: Colors.white,
            builder: (context) {
              return expandEditingText();
            },
          );
          focusNode.unfocus();
        }
      },
    );
  }

  Widget expandEditingText() {
    return BlocBuilder<PrimaryBloc, PrimaryState>(
      builder: (context, state) {
        return GestureDetector(
          onVerticalDragEnd: (details) {
            double velocity = details.primaryVelocity!;
            if (velocity > 0) {
              _closeSheet(state.bottomSheetIsopen!, context);
            } else if (velocity < 0) {
              _openSheet(state.bottomSheetIsopen!);
            }
          },
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: AnimatedContainer(
                width: double.maxFinite,
                color: Colors.white,
                height: state.bottomSheetIsopen == BottomSizes.minSize ||
                        state.bottomSheetIsopen == BottomSizes.closed
                    ? 100
                    : context.height,
                duration: const Duration(milliseconds: 400),
                child: BlocBuilder<DogBloc, DogState>(
                  builder: (context, state) {
                    return TextField(
                      controller: textController,
                      autofocus: true,
                      focusNode: focusNode,
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) {
                        context.read<DogBloc>().add(SearchBreedEvent(
                            searchText: textController.text,
                            breedsList: breedsList));
                      },
                      maxLines: null,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Search',
                          contentPadding: EdgeInsets.all(20)),
                    );
                  },
                )),
          ),
        );
      },
    );
  }

  void _closeSheet(BottomSizes sizes, context) {
    switch (sizes) {
      case BottomSizes.maxSize:
        _primaryBloc
            .add(BottomSheetEvent(bottomSheetIsopen: BottomSizes.minSize));
        break;
      case BottomSizes.minSize:
        _primaryBloc
            .add(BottomSheetEvent(bottomSheetIsopen: BottomSizes.closed));
        FocusManager.instance.primaryFocus?.unfocus();
        Navigator.pop(context);
        break;
      default:
    }
  }

  void _openSheet(BottomSizes sizes) {
    switch (sizes) {
      case BottomSizes.closed:
        _primaryBloc
            .add(BottomSheetEvent(bottomSheetIsopen: BottomSizes.minSize));
        break;
      case BottomSizes.minSize:
        _primaryBloc
            .add(BottomSheetEvent(bottomSheetIsopen: BottomSizes.maxSize));
        break;
      default:
    }
  }
}
