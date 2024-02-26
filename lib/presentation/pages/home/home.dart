import 'package:dog_app/business_logic/index.dart';
import 'package:dog_app/presentation/pages/home/home_mixin.dart';
import 'package:dog_app/models/breeds_response.dart';
import 'package:dog_app/presentation/widgets/subbreed_widget.dart';
import 'package:dog_app/utils/size_config.dart';
import 'package:dog_app/presentation/widgets/breed_item.dart';
import 'package:dog_app/presentation/widgets/custom_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomeMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        bottomSheet: Padding(
            padding: const EdgeInsets.only(left: 17.0, right: 17.0, bottom: 10),
            child: BlocBuilder<DogBloc, DogState>(
                builder: (context, state) {
                  if (state is SuccessState<FetchBreedsEvent, BreedsList>) {
                    return CustomBottomSheet(
                        primaryBloc: primaryBloc,
                        focusNode: focusNode,
                        textController: textController,
                        breedsList: state.data!);
                  }
                  return Container();
                },
                buildWhen: (previous, current) =>
                    current is SuccessState<FetchBreedsEvent, BreedsList>)),
        body: Container(
            padding: const EdgeInsets.only(
              left: 17.0,
              right: 17.0,
            ),
            child: BlocBuilder<DogBloc, DogState>(
              buildWhen: (previous, current) {
                return current is SuccessState<FetchBreedsEvent, BreedsList> ||
                    current is SuccessState<SearchBreedEvent, BreedsList> ||
                    current is FailureState;
              },
              builder: (context, state) {
                if (state is SuccessState<FetchBreedsEvent, BreedsList>) {
                  return GridView.builder(
                    shrinkWrap: true,
                    itemCount: state.data!.breeds
                        ?.where((element) =>
                            element.breedName == textController.text
                                ? true
                                : true)
                        .toList()
                        .length,
                    itemBuilder: (context, index) {
                      return BreedItem(
                          onTap: () async {
                            _showBreedDialog(
                                context, state.data!.breeds![index]);
                          },
                          image: imageCacheManager
                              .getImage(state.data!.breeds![index].imageUrl)!,
                          breedName: state.data!.breeds![index].breedName);
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: context.screenPaddingHorizontal.left,
                      mainAxisSpacing: context.screenPaddingHorizontal.left,
                    ),
                  );
                } else if (state
                    is SuccessState<SearchBreedEvent, BreedsList>) {
                  return GridView.builder(
                    shrinkWrap: true,
                    itemCount: state.data!.breeds
                        ?.where((element) =>
                            element.breedName == textController.text
                                ? true
                                : true)
                        .toList()
                        .length,
                    itemBuilder: (context, index) {
                      return BreedItem(
                          onTap: () async {
                            _showBreedDialog(
                                context, state.data!.breeds![index]);
                          },
                          image: imageCacheManager
                              .getImage(state.data!.breeds![index].imageUrl)!,
                          breedName: state.data!.breeds![index].breedName);
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: context.screenPaddingHorizontal.left,
                      mainAxisSpacing: context.screenPaddingHorizontal.left,
                    ),
                  );
                } else if (state is FailureState) {
                  return SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "No result found",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Try searching with another word",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff3C3C43).withOpacity(.60)),
                        )
                      ],
                    ),
                  );
                }
                return Container();
              },
            )));
  }
}

void _showBreedDialog(BuildContext context, Breed item) {
  showCupertinoModalPopup(
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
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        image: DecorationImage(
                          alignment: Alignment.topCenter,
                          image: NetworkImage(item.imageUrl),
                          fit: BoxFit.cover,
                        )),
                  ),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: IconButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SubBreedWidget(
                title: item.breedName,
                subChild: ListView.builder(
                  itemCount: item.subBreeds.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    return Text(
                      item.subBreeds[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20),
                    );
                  },
                )),
            BlocConsumer<DogBloc, DogState>(
              builder: (context, state) {
                return Container(
                  width: double.maxFinite,
                  margin: context.allPadding,
                  child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<DogBloc>()
                          .add(FetchSubBreedImageEvent(item.breedName));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: context.borderRadius),
                        padding: EdgeInsets.symmetric(
                            vertical: context.height * 0.02)),
                    child: (state is StateSubBreedImageFetching)
                        ? const SizedBox(
                            height: 24,
                            child: CircularProgressIndicator.adaptive(
                              backgroundColor: Colors.white,
                            ))
                        : const Text(
                            "Generate",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                  ),
                );
              },
              listener: (context, state) {
                if (state is StateSubBreedImageFetched) {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      return Container(
                        margin: const EdgeInsets.only(
                            left: 70, right: 70, top: 200, bottom: 200),
                        child: Column(
                          children: [
                            Image.network(
                              state.subBreedImage.message!,
                              width: 350,
                              height: 350,
                              fit: BoxFit.cover,
                            ),
                            IconButton(
                                splashRadius: 4,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Container(
                                  width: 40,
                                  height: 40,
                                  color: Colors.white,
                                  child: const Icon(Icons.close_rounded),
                                )),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      );
    },
  );
}
