import 'dart:ui';

import 'package:dog_app/utils/size_config.dart';
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
      borderRadius: context.borderRadius,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          borderRadius: context.borderRadius,
          image: DecorationImage(image: image.image, fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: context.borderRadius.bottomLeft,
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  height: 30,
                  width: 100,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: (context.borderRadius * 1.2).topRight,
                    ),
                    color: Colors.black.withOpacity(.24),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    breedName,
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
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
