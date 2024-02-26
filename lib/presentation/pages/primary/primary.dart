import 'package:dog_app/business_logic/index.dart';
import 'package:dog_app/utils/custom_painter.dart';
import 'package:dog_app/presentation/pages/home/home.dart';
import 'package:dog_app/presentation/pages/primary/primary_mixin.dart';
import 'package:dog_app/presentation/settings.dart';
import 'package:dog_app/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrimaryPage extends StatefulWidget {
  const PrimaryPage({super.key});

  @override
  State<PrimaryPage> createState() => _PrimaryPageState();
}

class _PrimaryPageState extends State<PrimaryPage> with PrimaryMixin {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PrimaryBloc, PrimaryState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text("Dog App"),
        ),
        body: changePageScreen(state.tabIndex!),
        bottomNavigationBar: CustomPaint(
          painter: BottomCustomPainter(),
          child: ClipPath(
              clipper: CustomBottomClipper(),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                selectedItemColor: ColorConstants.bottomBarSelectedColor,
                unselectedItemColor: ColorConstants.bottomBaruUnselectedColor,
                elevation: 0,
                currentIndex: state.tabIndex!,
                onTap: (value) {
                  primaryBloc.add(TabChangeEvent(tabIndex: value));
                },
                selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(IconConstants.houseline, size: 30),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(IconConstants.settings, size: 25),
                    label: "Settings",
                  ),
                ],
              )),
        ),
      ),
      listener: (BuildContext context, PrimaryState state) async {
        if (state.tabIndex == 1) {
          await showModalBottomSheet(
            isScrollControlled: true,
            useSafeArea: true,
            context: context,
            showDragHandle: true,
            backgroundColor: Colors.white,
            builder: (context) {
              return const SettingsPage();
            },
          );
          primaryBloc.add(TabChangeEvent(tabIndex: 0));
        }
      },
    );
  }
}

Widget changePageScreen(int index) {
  switch (index) {
    case 0:
      return const HomePage();
    default:
      return const HomePage();
  }
}
