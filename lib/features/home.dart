import 'package:dog_app/bloc/dog/dog_bloc.dart';
import 'package:dog_app/bloc/dog/dog_event.dart';
import 'package:dog_app/bloc/dog/dog_state.dart';
import 'package:dog_app/bloc/primary/primary_bloc.dart';
import 'package:dog_app/utils/image_cache_manager.dart';
import 'package:dog_app/widgets/breed_item.dart';
import 'package:dog_app/widgets/custom_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PrimaryBloc _primaryBloc;

  final TextEditingController textController = TextEditingController();
  late final ImageCacheManager _imageCacheManager;

  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _imageCacheManager = ImageCacheManager();
    _primaryBloc = BlocProvider.of<PrimaryBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DogBloc, DogState>(
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.transparent,
            bottomSheet: CustomBottomSheet(
                primaryBloc: _primaryBloc,
                focusNode: focusNode,
                textController: textController),
            body: Padding(
              padding: const EdgeInsets.only(left: 17.0, right: 17.0),
              child: Stack(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: state.breedsList!.breeds
                        ?.where((element) =>
                            element.breedName == textController.text
                                ? true
                                : true)
                        .toList()
                        .length,
                    itemBuilder: (context, index) {
                      return BreedItem(
                          onTap: () async {
                            BlocProvider.of<DogBloc>(context).add(
                                FetchSubBreedsEvent(state
                                    .breedsList!.breeds![index].breedName));
                            customDialog(context, state, index);
                          },
                          image: _imageCacheManager.getImage(
                              state.breedsList!.breeds![index].imageUrl)!,
                          breedName:
                              state.breedsList!.breeds![index].breedName);
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }

  void customDialog(BuildContext context, DogState state, int index) {
    showCupertinoModalPopup(
      useRootNavigator: false,
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          margin:
              const EdgeInsets.only(left: 30, right: 30, top: 100, bottom: 100),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    child: SizedBox(
                      width: double.infinity,
                      height: 400,
                      child: _imageCacheManager
                          .getImage(state.breedsList!.breeds![index].imageUrl)!,
                    ),
                  ),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: IconButton(
                      icon: const Icon(
                        Icons.cancel_rounded,
                        color: Colors.white,
                        size: 35,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
              BlocBuilder<DogBloc, DogState>(
                builder: (context, state) {
                  return Expanded(
                    child: CupertinoPicker.builder(
                      itemExtent: 32,
                      magnification: 1.12,
                      selectionOverlay: null,
                      childCount: state.subBreeds?.subBreeds?.length,
                      onSelectedItemChanged: (value) {
                        context
                            .read<DogBloc>()
                            .add(ChangeSelectionSubBreedEvent(value));
                      },
                      itemBuilder: (context, index) {
                        return Text(
                          "${state.subBreeds?.subBreeds?[index]}",
                          style: TextStyle(
                              color: state.selectionSubBreed == index
                                  ? Colors.blue
                                  : Colors.black),
                        );
                      },
                    ),
                  );
                },
              ),
              Material(
                child: GestureDetector(
                  onTap: () {
                    context.read<DogBloc>().add(FetchSubBreedImageEvent(
                        state.breedsList!.breeds![index].breedName,
                        state.subBreeds!.subBreeds![state.selectionSubBreed!]));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Generate",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                          BlocConsumer<DogBloc, DogState>(
                            builder: (context, state) {
                              if (state.subBreedImageStatus == Status.loading) {
                                return const CircularProgressIndicator
                                    .adaptive();
                              } else {
                                return Container();
                              }
                            },
                            listener: (context, state) async {
                              if (state.subBreedImageStatus == Status.success) {
                                await showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      margin: const EdgeInsets.only(
                                          left: 70,
                                          right: 70,
                                          top: 200,
                                          bottom: 200),
                                      child: Column(
                                        children: [
                                          Image.network(
                                            state.subBreedImage!.message!,
                                            width: 350,
                                            height: 350,
                                            fit: BoxFit.cover,
                                          ),
                                          IconButton(
                                              splashRadius: 4,
                                              onPressed: () {
                                                context
                                                    .read<DogBloc>()
                                                    .changeImageStatus(
                                                        Status.initial);
                                                Navigator.pop(context);
                                              },
                                              icon: Container(
                                                width: 40,
                                                height: 40,
                                                color: Colors.white,
                                                child: const Icon(
                                                    Icons.close_rounded),
                                              )),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
