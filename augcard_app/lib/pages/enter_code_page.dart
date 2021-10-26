import 'dart:io';

import 'package:augcard_app/pages/user_joined_page.dart';
import 'package:augcard_app/widgets/primary_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class EnterCodePage extends StatefulWidget {
  static const routeName = '/enter-code';
  const EnterCodePage({Key? key}) : super(key: key);

  @override
  _EnterCodePageState createState() => _EnterCodePageState();
}

class _EnterCodePageState extends State<EnterCodePage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // This steps are necessary for hot reload. See example code from package:qr_code_scanner
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = (Platform.isAndroid || Platform.isIOS);
    const sizedBox = SizedBox(height: 16);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan or Enter Code to Join Game'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          height: isMobile ? null : MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  (isMobile
                          ? 'Scan the projected QR-Code or enter '
                          : 'Enter ') +
                      'the digits below the QR-Code to join the game!',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              if (isMobile) SizedBox(height: 400, child: _buildQrView(context)),
              sizedBox,
              Text(
                (isMobile) ? 'Or Enter Code Manually:' : 'Enter Code:',
                style: Theme.of(context).textTheme.headline6,
              ),
              sizedBox,
              Container(
                width: 300,
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(),
                ),
              ),
              sizedBox,
              SizedBox(
                width: 300,
                child: PrimaryButton(
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Join Game'),
                  ),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(UserJoinedPage.routeName),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Theme.of(context).colorScheme.secondary,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, permission) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text(permission ? 'Permission received.' : 'No Permission!')));
      },
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
