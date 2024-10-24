import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hse_app/bloc/cubit/scan_cubit.dart';
import 'package:hse_app/bloc/cubit/scan_state.dart';
import 'package:hse_app/service.dart';
import 'package:hse_app/widgets/custom_appbar.dart';
import 'package:hse_app/widgets/custom_footer.dart';
import 'package:hse_app/widgets/not_orignal_product.dart';
import 'package:hse_app/widgets/orignal_product.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({key}) : super(key: key);

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
    return BlocProvider(
      create: (context) => ScanCubit(Services()),
      child: Scaffold(
        appBar: CustomAppBar(
          widgett: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Color.fromRGBO(255, 186, 0, 1),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(255, 186, 0, 0.24),
                      offset: Offset(0, 4),
                      blurRadius: 8,
                      spreadRadius: 4),
                ]),
            child: const Icon(
              Icons.keyboard_arrow_right_sharp,
              size: 30,
            ),
          ),
          text: 'توثيق منتج',
          image2: 'assets/hse.png',
        ),
        body: Column(
          children: <Widget>[
            Expanded(flex: 12, child: _buildQrView(context)),
            const Expanded(
              child: Stack(
                children: [
                  CustomFooter(
                    num: 60,
                    num2: 24,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
    // );
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
      controller.pauseCamera();
      _showResultDialog(context, result!.code);
    });
  }

  void _showResultDialog(BuildContext context, String? code) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => ScanCubit(Services()),
          child: Builder(
            builder: (context) {
              context.read<ScanCubit>().scanQRCode(code!);
              return BlocBuilder<ScanCubit, ScanState>(
                builder: (context, state) {
                  if (state is ScanLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ScanSuccess) {
                    return OrignalProduct(
                      controller: controller,
                      product: state.product,
                    );
                  } else if (state is ScanFailure) {
                    return NotOriginalProduct(controller: controller);
                  } else {
                    return const Center(child: Text('Unexpected state'));
                  }
                },
              );
            },
          ),
        );
      },
    );
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
