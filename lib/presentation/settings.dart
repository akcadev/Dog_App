import 'package:dog_app/utils/index.dart';
import 'package:dog_app/utils/utils.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String osVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    getOsVersion();
  }

  getOsVersion() async {
    String version = await Utils().getOSVersion();
    setState(() {
      osVersion = version;
    });
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w500);
    return Column(
      children: [
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            (IconConstants.help, "Help", null),
            (IconConstants.rateus, "Rate Us", null),
            (IconConstants.sharefriends, "Share With Friends", null),
            (IconConstants.privacypolicy, "Privacy Policy", null),
            (IconConstants.osversion, "Os Version", Icons.arrow_outward_rounded)
          ]
              .map((e) => ListTile(
                    shape: Border(
                        bottom: BorderSide(color: Colors.grey.withOpacity(.3))),
                    titleAlignment: ListTileTitleAlignment.center,
                    leading: Icon(
                      e.$1,
                      size: 30,
                    ),
                    trailing: e.$3 != null
                        ? Text(
                            osVersion,
                            style: const TextStyle(fontSize: 12),
                          )
                        : Icon(
                            e.$3,
                            size: 18,
                            color: Colors.grey,
                          ),
                    title: Text(
                      e.$2,
                      style: textStyle,
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
