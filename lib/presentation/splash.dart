import 'package:dog_app/business_logic/index.dart';
import 'package:dog_app/models/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<DogBloc>().add(FetchBreedsEvent());

    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Image.asset("assets/dog-app.png")),
        BlocConsumer<DogBloc, DogState>(
          builder: (context, state) {
            if (state is StateBreedsFetching) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Veriler Çekiliyor",
                  style: TextStyle(
                      color: Colors.grey.withOpacity(.4), letterSpacing: .5),
                ),
              );
            } else if (state is StateBreedsCaching) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Görseller Yükleniyor",
                  style: TextStyle(
                      color: Colors.grey.withOpacity(.4), letterSpacing: .5),
                ),
              );
            } else {
              return Container();
            }
          },
          listener: (context, state) {
            if (state is SuccessState<FetchBreedsEvent, BreedsList>) {
              Navigator.pushReplacementNamed(context, "/primary");
            }
          },
        )
      ],
    ));
  }
}
