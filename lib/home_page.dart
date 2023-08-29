import 'package:flash_light_app/components.dart';
import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  bool flash = false;
  IconData icon = Icons.flash_off;
  String flashing = 'OFF';

  @override
  void convert(flash) {
    if (flash != true) {
      flashing = 'OFF';
      icon = Icons.flash_off;
      _disableTorch(context);
    } else {
      _enableTorch(context);
      flashing = 'ON';
      icon = Icons.flash_on;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Torch App'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Text(
            'Flashlight',
            style: TextStyle(
              fontSize: 50.0,
              color: Colors.green[500],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: 3.0,
            color: Colors.black,
            width:  MediaQuery.of(context).size.width * 0.8,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
          ),
          Center(
            child: Container(
              width:MediaQuery.of(context).size.width * 0.35,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(30.0),
                boxShadow:const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: Offset(0, 3)
                    ,
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    flash = !flash;
                    convert(flash);
                  });
                },
                child: Text(
                  flashing,
                  style: TextStyle(
                    fontSize: 35.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _enableTorch(BuildContext context) async {
    try {
      await TorchLight.enableTorch();
    } on Exception catch (_) {
      showToast('Could not disable torch');
    }
  }

  Future<void> _disableTorch(BuildContext context) async {
    try {
      await TorchLight.disableTorch();
    } on Exception catch (_) {
      showToast('Could not disable torch');
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      _disableTorch(context);
    } else {
      _enableTorch(context);
    }
  }
}
