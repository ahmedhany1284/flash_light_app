import 'package:flash_light_app/components.dart';
import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<MyHomePage> {
  bool flash = false;
  IconData icon = Icons.flash_off;
  String flashing = 'flash off';

  @override
  void convert(flash) {
    if (flash != true) {
      flashing = 'flash off';
      icon = Icons.flash_off;
      _disableTorch(context);
    } else {
      _enableTorch(context);
      flashing = 'flash on';
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
            width: 200.0,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
          ),
          Center(
            child: IconButton(
              onPressed: () {
                setState(() {
                  flash = !flash;
                  convert(flash);
                });
              },
              icon: Icon(
                icon,
                size: 100.0,
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
      showToast('Could not disable torch' );
    }
  }

  Future<void> _disableTorch(BuildContext context) async {
    try {
      await TorchLight.disableTorch();
    } on Exception catch (_) {
      showToast('Could not disable torch' );
    }
  }




}
