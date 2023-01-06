import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keychain/flutter_keychain.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String value = "";
  String identifierForVendor = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("checkDeviceInfo"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Text("current identifierForVendor\n$value"),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () async {
                  final deviceInfoPlugin = DeviceInfoPlugin();
                  IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
                  print('identifierForVendor${iosInfo.identifierForVendor}');
                  value = iosInfo.identifierForVendor.toString();
                  setState(() {});
                },
                child: const Text("button")),
            const SizedBox(height: 30),
            Text("key store identifierForVendor\n$identifierForVendor"),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () async {
                  var value = await FlutterKeychain.get(key: "identifierForVendor");
                  identifierForVendor = value.toString();
                  setState(() {});
                },
                child: const Text("get Key")),
            ElevatedButton(
                onPressed: () async {
                  await FlutterKeychain.put(key: "identifierForVendor", value: value);
                  setState(() {});
                },
                child: const Text("put Key")),
          ],
        ),
      ),
    );
  }
}
