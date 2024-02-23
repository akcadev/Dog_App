import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  static const platform = const MethodChannel('com.example.dog_app/os_version');
  String osVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    getOSVersion();
  }

  Future<void> getOSVersion() async {
    String version;
    try {
      final String result =
          await const MethodChannel('com.example.dog_app/os_version')
              .invokeMethod('getOSVersion');
      version = result;
    } on PlatformException catch (e) {
      version = 'Failed to get OS version: $e';
    }

    setState(() {
      osVersion = version;
    });
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w500);
    return ListView(
      children: [
        const ListTile(
          titleAlignment: ListTileTitleAlignment.center,
          trailing: Icon(
            Icons.arrow_outward_rounded,
            size: 18,
            color: Colors.grey,
          ),
          leading: Icon(
            Icons.info_outline_rounded,
            size: 30,
          ),
          title: Text(
            "Help",
            style: textStyle,
          ),
        ),
        const ListTile(
          titleAlignment: ListTileTitleAlignment.center,
          trailing: Icon(
            Icons.arrow_outward_rounded,
            size: 18,
            color: Colors.grey,
          ),
          leading: Icon(
            Icons.star_border_rounded,
            size: 30,
          ),
          title: Text(
            "Rate Us",
            style: textStyle,
          ),
        ),
        const ListTile(
          titleAlignment: ListTileTitleAlignment.center,
          trailing: Icon(
            Icons.arrow_outward_rounded,
            size: 18,
            color: Colors.grey,
          ),
          leading: Icon(
            Icons.ios_share_rounded,
            size: 30,
          ),
          title: Text(
            "Share With Friends",
            style: textStyle,
          ),
        ),
        const ListTile(
          titleAlignment: ListTileTitleAlignment.center,
          trailing: Icon(
            Icons.arrow_outward_rounded,
            size: 18,
            color: Colors.grey,
          ),
          leading: Icon(
            Icons.local_police_outlined,
            size: 30,
          ),
          title: Text(
            "Privacy Policy",
            style: textStyle,
          ),
        ),
        ListTile(
          titleAlignment: ListTileTitleAlignment.center,
          trailing: Text(
            osVersion,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          leading: const Icon(
            size: 30,
            Icons.settings_system_daydream_rounded,
          ),
          title: const Text(
            "OS Version",
            style: textStyle,
          ),
        )
      ],
    );
  }
}
