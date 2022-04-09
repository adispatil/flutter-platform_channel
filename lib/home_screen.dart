import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const appChannel = MethodChannel('com.platform_channel_demo');
  var _batteryLevel = "0 %";
  var _deviceName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Platform Channel'),
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await getBatteryLevel();
                },
                child: const Text('Battery Level'),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                _batteryLevel,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              ElevatedButton(
                onPressed: () async {
                  await getDeviceName();
                },
                child: const Text('Device Name'),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                _deviceName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getBatteryLevel() async {
    String batteryPercentage;
    try {
      var result = await appChannel.invokeMethod('getBatteryLevel');
      batteryPercentage = '$result %';
    } on PlatformException catch (ex) {
      batteryPercentage = "Failed to get battery percentage ${ex.message}";
    } on MissingPluginException catch (ex) {
      batteryPercentage = "Failed to get battery percentage ${ex.message}";
    } catch (ex) {
      batteryPercentage = "Failed to get battery percentage $ex";
      print(ex);
    }

    setState(() {
      _batteryLevel = batteryPercentage;
    });
  }

  Future<void> getDeviceName() async {
    String deviceName;
    try {
      var result = await appChannel.invokeMethod('getDeviceName');
      deviceName = '$result';
    } on PlatformException catch (ex) {
      deviceName = "Failed to get device name ${ex.message}";
    } on MissingPluginException catch (ex) {
      deviceName = "Failed to get device name ${ex.message}";
    } catch (ex) {
      deviceName = "Failed to get device name $ex";
    }

    setState(() {
      _deviceName = deviceName;
    });
  }
}
