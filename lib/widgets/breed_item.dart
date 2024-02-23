import 'dart:ui';

import 'package:flutter/material.dart';

class BreedItem extends StatelessWidget {
  const BreedItem(
      {super.key,
      required this.image,
      required this.breedName,
      required this.onTap});
  final Image image;
  final String breedName;
  final GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            image,
            Align(
              alignment: Alignment.bottomLeft,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                  child: Container(
                    width: 75,
                    height: 35,
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.3),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10))),
                    child: Text(
                      breedName,
                      style: const TextStyle(
                          color: Colors.white, overflow: TextOverflow.clip),
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
