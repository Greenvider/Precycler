import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

const flash_on = "FLASH ON";
const flash_off = "FLASH OFF";
const front_camera = "FRONT CAMERA";
const back_camera = "BACK CAMERA";

class QrScannerWidget extends StatefulWidget {
  const QrScannerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrScannerWidgetState();
}

class _QrScannerWidgetState extends State<QrScannerWidget> {
  bool Done_Button = false;
  var qrText;
  late QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.blueAccent,
              borderRadius: 10,
              borderLength: 130,
              borderWidth: 5,
              overlayColor: const Color(0xff010040),
            ),
          ),

          flex: 4,
        ),
        Expanded(
          child: FittedBox(
            fit: BoxFit.contain,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("$qrText", style: const TextStyle(color: Colors.black,),),
                InkWell(
                  onTap: () async {

                  },
                  child: Container(
                    width: 100.0,
                    height: 50.0,
                    decoration: const BoxDecoration(
                        borderRadius: const BorderRadius.all(const Radius.circular(5)),
                        gradient: const LinearGradient(colors: const [
                          const       Color(0xFF1E75BB),
                          const Color(0xFF1EEABB),
                        ])),
                    child: const Center(
                      child: const Text(
                        'Done',
                        style: const TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Play',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () async {
                    setState(() {
                      qrText = "";
                      controller.resumeCamera();
                      Done_Button = false;
                    });
                  },
                  child: Container(
                    width: 100.0,
                    height: 50.0,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(const Radius.circular(5)),
                        gradient: const LinearGradient(colors: [
                          const Color(0xFF1E75BB),
                          const Color(0xFF1EEABB),
                        ])),
                    child: const Center(
                      child: const Text(
                        'Again',
                        style: const TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Play',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          flex: 1,
        ),
      ],
    );
  }

  d(String current) {
    return flash_on == current;
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
        controller.pauseCamera();
        Done_Button = true;
      });
    });
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}