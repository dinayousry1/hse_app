import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hse_app/widgets/custom_appbar.dart';
import 'package:hse_app/widgets/custom_footer.dart';
import 'package:hse_app/widgets/not_orignal_product.dart';
import 'package:hse_app/widgets/orignal_product.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        image1: 'assets/Menu.png',
        text: 'توثيق منتج',
        image2: 'assets/HSE  LOGO.png',
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 13, child: _buildQrView(context)),
          const Expanded(
            child: Stack(
              children: [CustomFooter(num: 50)],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 600 ||
            MediaQuery.of(context).size.height < 600)
        ? 300.0
        : 450.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: const Color.fromRGBO(236, 103, 7, 1),
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
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
      _showResultDialog(context, result!.code);
    });
  }

  // void _showResultDialog(BuildContext context, String? code) {
  //   String message = code == 'original'
  //       ? 'The product is original.'
  //       : 'The product is not original.';
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Scan Result'),
  //       content: Text(message),
  //       actions: [
  //         TextButton(
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //             controller?.resumeCamera();
  //           },
  //           child: const Text('OK'),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  void _showResultDialog(BuildContext context, String? code) {
    if (code == 'original') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const OrignalProduct();
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const NotOrignalProduct();
        },
      );
    }
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
