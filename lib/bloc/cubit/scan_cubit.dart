import 'package:bloc/bloc.dart';
import 'package:hse_app/bloc/cubit/scan_state.dart';
import 'package:hse_app/service.dart';

class ScanCubit extends Cubit<ScanState> {
  final Services services;

  ScanCubit(this.services) : super(ScanInitial());

  Future<void> scanQRCode(String qr) async {
    emit(ScanLoading());
    try {
      final productModel = await services.scanQRCode(qr);
      // print("productModel : ${productModel}");
      if (productModel != null) {
        emit(ScanSuccess(productModel));
      } else {
        emit(ScanFailure('Product is not original or data is unavailable.'));
      }
    } catch (e) {
      emit(ScanFailure('Failed to scan QR code: $e'));
    }
  }
}
