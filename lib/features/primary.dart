import 'package:dog_app/bloc/primary/primary_bloc.dart';
import 'package:dog_app/bloc/primary/primary_event.dart';
import 'package:dog_app/bloc/primary/primary_state.dart';
import 'package:dog_app/custom_painter.dart';
import 'package:dog_app/features/settings.dart';
import 'package:dog_app/utils/color_constants.dart';
import 'package:dog_app/utils/icons.dart';
import 'package:dog_app/features/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrimaryPage extends StatefulWidget {
  const PrimaryPage({super.key});

  @override
  State<PrimaryPage> createState() => _PrimaryPageState();
}

class _PrimaryPageState extends State<PrimaryPage> {
  late PrimaryBloc _primaryBloc;

  @override
  void initState() {
    _primaryBloc = BlocProvider.of<PrimaryBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrimaryBloc, PrimaryState>(
        builder: (context, state) => Scaffold(
              appBar: AppBar(title: const Text("Dog App"),),
              body: bottomNavScreen.elementAt(state.tabIndex!),
              bottomNavigationBar: CustomPaint(
                painter: BottomCustomPainter(),
                child: ClipPath(
                    clipper: CustomBottomClipper(),
                    child: BottomNavigationBar(
                      backgroundColor: Colors.transparent,
                      selectedItemColor: ColorConstants.bottomBarSelectedColor,
                      unselectedItemColor:
                          ColorConstants.bottomBaruUnselectedColor,
                      elevation: 0,
                      currentIndex: state.tabIndex!,
                      onTap: (value) {
                        _primaryBloc.add(TabChangeEvent(tabIndex: value));
                      },
                      items: const [
                        BottomNavigationBarItem(
                          icon: Icon(IconConstants.houseline, size: 30),
                          label: "Ana Sayfa",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(IconConstants.settings, size: 25),
                          label: "Ayarlar",
                        ),
                      ],
                    )),
              ),
            ));
  }
}

const List<Widget> bottomNavScreen = <Widget>[
  HomePage(),
  SettingsPage(),
];
