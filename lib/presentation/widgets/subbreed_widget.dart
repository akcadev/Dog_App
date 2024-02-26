import 'package:dog_app/utils/index.dart';
import 'package:flutter/material.dart';

class SubBreedWidget extends StatelessWidget {
  const SubBreedWidget({super.key, required this.title, required this.subChild});
  final String title;
  final Widget subChild;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: context.borderRadius,
        child: Material(
          child: Column(
            children: [
              const Text(
                "Breed",
                style: TextStyle(
                    color: Color(0xff0055D3),
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
              Divider(
                indent: 20,
                endIndent: 20,
                thickness: 2,
                color: Colors.grey.withOpacity(.2),
              ),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const Text(
                "Sub Breed",
                style: TextStyle(
                    color: Color(0xff0055D3),
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
              Divider(
                indent: 20,
                endIndent: 20,
                thickness: 2,
                color: Colors.grey.withOpacity(.2),
              ),
              Expanded(
                child: subChild,
              )
            ],
          ),
        ),
      ),
    );
    
  }
}
